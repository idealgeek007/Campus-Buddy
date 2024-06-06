import 'package:campus_buddy/Utils/SizeConfig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MaintenanceReportingPage extends StatefulWidget {
  @override
  _MaintenanceReportingPageState createState() =>
      _MaintenanceReportingPageState();
}

class _MaintenanceReportingPageState extends State<MaintenanceReportingPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  File? _image;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _submitReport() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = _auth.currentUser!;
        final userDoc =
            await _firestore.collection('users').doc(user.email).get();
        final userData = userDoc.data();

        if (_image != null) {
          String imagePath =
              'maintenance_reports/${user.email}_${DateTime.now().millisecondsSinceEpoch}.jpg';
          TaskSnapshot snapshot =
              await _storage.ref(imagePath).putFile(_image!);
          String imageUrl = await snapshot.ref.getDownloadURL();

          await _firestore.collection('maintenance_reports').add({
            'description': _descriptionController.text.trim(),
            'location': _locationController.text.trim(),
            'imageUrl': imageUrl,
            'reportedBy': {
              'name': userData!['name'],
              'email': user.email,
              'sem': userData['sem'],
              'div': userData['div'],
              'branch': userData['branch'],
            },
            'timestamp': FieldValue.serverTimestamp(),
          });

          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Report submitted successfully')));
          Navigator.pop(context);
        } else {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Please upload an image')));
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error submitting report: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maintenance Reporting',
          style: GoogleFonts.poppins(
              fontSize: width * 0.05, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Describe the problem',
                        labelStyle: GoogleFonts.poppins(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        labelStyle: GoogleFonts.poppins(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    _image == null
                        ? Text(
                            'No image selected.',
                            style: GoogleFonts.poppins(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.w500),
                          )
                        : Image.file(_image!),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text(
                        'Upload Image',
                        style: GoogleFonts.poppins(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Color(0xff8cbfae)
                                : Color(0xffC3E2C2),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submitReport,
                      child: Text(
                        'Submit Report',
                        style: GoogleFonts.poppins(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Color(0xff8cbfae)
                                : Color(0xffC2DAE2),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

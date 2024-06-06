import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';

import '../../Utils/SizeConfig.dart';

class TimeTables extends StatefulWidget {
  const TimeTables({super.key});

  @override
  State<TimeTables> createState() => _TimeTablesState();
}

class _TimeTablesState extends State<TimeTables> {
  final ImagePicker _picker = ImagePicker();
  final user = FirebaseAuth.instance.currentUser!;
  bool isCR = false;
  bool isAdmin = false;
  String semester = '';
  String division = '';

  @override
  void initState() {
    super.initState();
    getUserRoleAndClass();
  }

  void getUserRoleAndClass() async {
    var userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get();
    setState(() {
      isCR = userDoc.data()?['isCR'] ?? false;
      isAdmin = userDoc.data()?['isAdmin'] ?? false;
      semester = userDoc.data()?['sem'].toString() ?? '';
      division = userDoc.data()?['division'] ?? '';
    });
  }

  Future<void> uploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      try {
        String path =
            'timetables/$semester$division/${DateTime.now().millisecondsSinceEpoch}.png';
        await FirebaseStorage.instance.ref(path).putFile(file);
        String downloadUrl =
            await FirebaseStorage.instance.ref(path).getDownloadURL();
        FirebaseFirestore.instance.collection('timetable_uploads').add({
          'uploadedBy': user.email,
          'downloadUrl': downloadUrl,
          'semester': semester,
          'division': division,
          'timestamp': FieldValue.serverTimestamp(),
        });
        print('Upload successful');
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  void _openImageView(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text("View Image"),
                ),
                body: Container(
                  child: PhotoView(
                    imageProvider: NetworkImage(imageUrl),
                    backgroundDecoration: BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                ),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Timetable',
          style: GoogleFonts.poppins(
            fontSize: SizeConfig.screenWidth / 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isCR || isAdmin)
            ElevatedButton(
              onPressed: uploadImage,
              child: Text(
                'Upload Timetable',
                style: GoogleFonts.poppins(
                  fontSize: SizeConfig.screenWidth / 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 4,
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xff8cbfae)
                    : Color(0xffC3E2C2),
              ),
            ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('timetable_uploads')
                  .where('semester', isEqualTo: semester)
                  .where('division', isEqualTo: division)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error loading timetables'));
                }
                if (snapshot.data?.docs.isEmpty ?? true) {
                  return Center(
                      child: Text('No timetables found for your class'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    return Card(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xff8cbfae)
                          : Color(0xffC3E2C2),
                      elevation: 4,
                      child: ListTile(
                        onTap: () =>
                            _openImageView(context, doc['downloadUrl']),
                        title: Image.network(doc['downloadUrl']),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Uploaded by: ${doc['uploadedBy']}',
                            style: GoogleFonts.poppins(
                              fontSize: SizeConfig.screenWidth / 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        trailing: (isCR || isAdmin)
                            ? IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => doc.reference.delete(),
                              )
                            : null,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:campus_buddy/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceTracker extends StatefulWidget {
  const AttendanceTracker({super.key});

  @override
  State<AttendanceTracker> createState() => _AttendanceTrackerState();
}

class _AttendanceTrackerState extends State<AttendanceTracker> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _attendedClassesController =
      TextEditingController();
  final TextEditingController _totalClassesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance Tracker',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddSubjectDialog(context),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth
                .instance.currentUser?.email) // Using email as document ID.
            .collection('subjects')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                var attended = doc['attendedClasses'];
                var total = doc['totalClasses'];
                var percentage = (attended / total * 100).toStringAsFixed(1);

                //
                //
                //

                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      splashColor: Colors.blue,
                      title: Text(
                        doc['subjectName'],
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(bottom: 35, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Attendance: $attended / $total ',
                              style: GoogleFonts.poppins(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '$percentage%',
                              style: GoogleFonts.poppins(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                color: Colors.red[400],
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => _updateTotalClassesOnly(
                                  doc.id, attended, total),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  _incrementAttendance(doc.id, attended, total),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            color: Colors.blue,
                            icon: const Icon(
                              Icons.edit,
                              size: 35,
                            ),
                            onPressed: () =>
                                _showEditSubjectDialog(context, doc),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No subjects added'));
          }
        },
      ),
    );
  }

  void _incrementAttendance(String docId, int attended, int total) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('subjects')
        .doc(docId)
        .update({
      'attendedClasses': attended + 1,
      'totalClasses': total + 1
    }).catchError((error) => print('Failed to increment attendance: $error'));
  }

  void _updateTotalClassesOnly(String docId, int attended, int total) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('subjects')
        .doc(docId)
        .update({'totalClasses': total + 1}).catchError(
            (error) => print('Failed to increment total classes: $error'));
  }

  void _showAddSubjectDialog(BuildContext context) {
    _subjectController.clear();
    _attendedClassesController.clear();
    _totalClassesController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Subject'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject Name'),
              ),
              TextFormField(
                controller: _attendedClassesController,
                decoration:
                    const InputDecoration(labelText: 'Classes Attended'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _totalClassesController,
                decoration: const InputDecoration(labelText: 'Total Classes'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: _addSubject,
            ),
          ],
        );
      },
    );
  }

  void _addSubject() {
    final String subjectName = _subjectController.text.trim();
    final int attendedClasses =
        int.tryParse(_attendedClassesController.text.trim()) ?? 0;
    final int totalClasses =
        int.tryParse(_totalClassesController.text.trim()) ?? 0;

    if (totalClasses < attendedClasses || totalClasses == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Total classes must be greater than classes attended and not zero'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('subjects')
        .add({
      'subjectName': subjectName,
      'attendedClasses': attendedClasses,
      'totalClasses': totalClasses
    }).then((_) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Subject added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add subject: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  void _showEditSubjectDialog(BuildContext context, DocumentSnapshot doc) {
    _subjectController.text = doc['subjectName'];
    _attendedClassesController.text = doc['attendedClasses'].toString();
    _totalClassesController.text = doc['totalClasses'].toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Subject'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject Name'),
              ),
              TextFormField(
                controller: _attendedClassesController,
                decoration:
                    const InputDecoration(labelText: 'Classes Attended'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _totalClassesController,
                decoration: const InputDecoration(labelText: 'Total Classes'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save Changes'),
              onPressed: () => _updateSubject(doc.id),
            ),
          ],
        );
      },
    );
  }

  void _updateSubject(String docId) {
    final int attendedClasses =
        int.tryParse(_attendedClassesController.text.trim()) ?? 0;
    final int totalClasses =
        int.tryParse(_totalClassesController.text.trim()) ?? 0;

    if (totalClasses < attendedClasses) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Total classes must be greater than classes attended'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('subjects')
        .doc(docId)
        .update({
      'subjectName': _subjectController.text.trim(),
      'attendedClasses': attendedClasses,
      'totalClasses': totalClasses
    }).then((_) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Subject updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update subject: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
}

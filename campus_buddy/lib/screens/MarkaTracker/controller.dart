import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class SubjectProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, TextEditingController> ia1Controllers = {};
  Map<String, TextEditingController> ia2Controllers = {};
  Map<String, TextEditingController> ia3Controllers = {};

  List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  SubjectProvider() {
    fetchSubjects();
  }

  void fetchSubjects() {
    _firestore
        .collection('users')
        .doc(_auth.currentUser?.email)
        .collection('IA_marks')
        .snapshots()
        .listen((snapshot) {
      _subjects = snapshot.docs
          .map((doc) =>
              Subject.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      _subjects.forEach((subject) {
        ia1Controllers[subject.id] =
            TextEditingController(text: subject.ia1.toString());
        ia2Controllers[subject.id] =
            TextEditingController(text: subject.ia2.toString());
        ia3Controllers[subject.id] =
            TextEditingController(text: subject.ia3.toString());
      });
      notifyListeners();
    });
  }

  void updateSubject(Subject subject) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser?.email)
        .collection('IA_marks')
        .doc(subject.id)
        .update(subject.toFirestore());
    notifyListeners();
  }

  void addSubject(Subject subject) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser?.email)
        .collection('IA_marks')
        .add(subject.toFirestore());
    notifyListeners();
  }

  void deleteSubject(String subjectId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.email)
          .collection('IA_marks')
          .doc(subjectId)
          .delete();

      _subjects.removeWhere((subject) => subject.id == subjectId);
      notifyListeners();

      print('Subject deleted successfully');
    } catch (e) {
      print('Failed to delete subject: $e');
    }
  }
}

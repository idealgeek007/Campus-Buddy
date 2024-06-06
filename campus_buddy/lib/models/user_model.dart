import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String name;
  final String id;
  String email;
  bool isCR;
  String branch;
  bool isAdmin;
  String div;
  int sem;

  Users({
    required this.div,
    required this.sem,
    required this.isCR,
    required this.branch,
    required this.name,
    required this.id,
    required this.email,
    required this.isAdmin,
  });

  factory Users.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Users(
      branch: data['branch'],
      name: data['name'],
      id: doc.id,
      email: data['email'],
      isCR: data['isCR'],
      isAdmin: data['isAdmin'],
      div: data['division'],
      sem: data['sem'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String name;
  final String id;
  final String email;
  final bool isCR;
  final String usn;
  final bool isAdmin;

  Users({
    required this.isCR,
    required this.usn,
    required this.name,
    required this.id,
    required this.email,
    required this.isAdmin,
  });

  factory Users.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Users(
      usn: data['usn'],
      name: data['name'],
      id: doc.id,
      email: data['email'],
      isCR: data['isCR'],
      isAdmin: data['isAdmin'],
    );
  }
}

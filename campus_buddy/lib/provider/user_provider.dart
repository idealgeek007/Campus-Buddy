import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  Users? get user => _user;

  Future<void> fetchUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && currentUser.email != null) {
        String userEmail = currentUser.email!;
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          _user = Users.fromFirestore(querySnapshot.docs.first);
          notifyListeners();
        } else {
          print('No user found with the email: $userEmail');
        }
      } else {
        print('No current user or email is null');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}

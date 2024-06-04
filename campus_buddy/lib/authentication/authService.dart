import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //Sign In
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the user's email is verified
      if (!userCredential.user!.emailVerified) {
        throw FirebaseAuthException(
          code: 'email_not_verified',
          message: 'Please verify your email before proceeding.',
        );
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign OUT
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // Sign UP
  Future<UserCredential> signUpWithEmailPassword(String email, String password,
      String name, int sem, String division) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();

      // Add additional user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'name': name,
        'email': email,
        'SEM': sem,
        'division': division,
        'isAdmin': false,
        'isCR': false,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception('An unknown error occurred');
    }
  }
  //
  //
  //

// is Email Verified
  Future<bool> isEmailVerified(String email) async {
    try {
      User? user = getCurrentUser();
      await user!.reload(); // Reload the user to get the latest data
      return user.emailVerified;
    } catch (e) {
      print('Error checking email verification: $e');
      return false;
    }
  }

// Resend Verification link
  Future<void> resendVerificationEmail() async {
    User? user = getCurrentUser();
    if (user != null) {
      await user.sendEmailVerification();
    }
  }
}

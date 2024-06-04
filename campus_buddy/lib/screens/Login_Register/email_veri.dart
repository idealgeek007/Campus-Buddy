import 'package:campus_buddy/screens/Login_Register/signupnew.dart';
import 'package:flutter/material.dart';

import '../../authentication/authService.dart';
import '../mainPage.dart';

class EmailNotVerifiedPage extends StatelessWidget {
  final String email;

  const EmailNotVerifiedPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Email Not Verified. Please check your mail for verification link'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your email has not been verified.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Resend verification email
                try {
                  await AuthService().resendVerificationEmail();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Verification email sent. Please check your inbox.'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Failed to resend verification email. Please try again later.'),
                    ),
                  );
                }
              },
              child: Text('Resend Verification Email'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Check if the email is verified
                bool isEmailVerified =
                    await AuthService().isEmailVerified(email);
                if (isEmailVerified) {
                  // Navigate to home page
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Your email is still not verified. Please verify your email before proceeding.'),
                    ),
                  );
                }
              },
              child: Text('I Have Verified My Email'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate back to login or register page
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}

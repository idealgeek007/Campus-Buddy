import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../Utils/SizeConfig.dart';
import '../../Utils/constants.dart';
import '../../authentication/authService.dart';
import '../../components/myButton.dart';
import '../../components/myTextfield.dart';
import '../../components/mydivider.dart';
import '../mainPage.dart';
import 'signupnew.dart';
import '../reset_pswd.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late FirebaseAuth _auth; // Add this line
  String user_name = ''; // Add these lines
  String user_email = '';

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance; // Add this line
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Positioned(
            top: -200,
            right: 60,
            child: Image.asset(
              "assets/images/gradients/Group 1.png",
              fit: BoxFit.fill,
              scale: 2,
            ),
          ),
          Positioned(
            bottom: -200,
            left: -1,
            child: Image.asset(
              "assets/images/gradients/Group 1.png",
              fit: BoxFit.cover,
              scale: 2,
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: width / 3,
                    ),
                    Text(
                      'Hello Again !',
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back to CAMPUS BUDDY 🧑‍🎓",
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "You’ve been missed",
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Email',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                          MyTextField(
                            keyboardtype: TextInputType.emailAddress,
                            controller: _emailController,
                            autofillhints: [AutofillHints.email],
                            hint: 'Enter your email',
                            obscure: false,
                            selection: true,
                            preIcon: Icons.email_outlined,
                            validator: (email) {
                              if (email!.isEmpty)
                                return "Please enter email";
                              else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0.9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ).hasMatch(email)) {
                                return "Please Enter a valid email";
                              }
                            },
                          ),
                          /* SizedBox(
                            height: width * 0.05,
                          ),*/
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Password',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                          MyTextField(
                            autofillhints: [AutofillHints.password],
                            controller: _passwordController,
                            hint: 'Enter your password',
                            obscure: true,
                            selection: false,
                            preIcon: Icons.password_outlined,
                            suffixIcon: Icons.abc,
                            validator: (password) {
                              if (password!.isEmpty) {
                                return "Please Enter the password";
                              } else if (password.length < 7)
                                return "Please enter minimum 8 letters";
                            },
                            keyboardtype: TextInputType.emailAddress,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPasswordPage()),
                              );
                            },
                            child: Text(
                              'Forgot Passowrd?',
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: width * 0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //Sign in Button
                              MyButton(
                                  onTap: () => login(context),
                                  text: 'Log In',
                                  color: Theme.of(context).colorScheme.primary),
                              SizedBox(
                                height: width * 0.05,
                              ),
                              myDivider(),

                              SizedBox(
                                height: width * 0.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: width * 0.04,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUpPage()),
                                      );
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.poppins(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                        fontSize: width * 0.04,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login(BuildContext context) async {
    // get auth service
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }
}

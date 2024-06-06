import 'package:campus_buddy/screens/Login_Register/email_veri.dart';
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
import 'loginnew.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usnController = TextEditingController();
  final AuthService _authService = AuthService();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  CollectionReference collRef = FirebaseFirestore.instance.collection('Users');

  // New additions
  String? _selectedSem;
  String? _selectedBrnach;
  String? _selectedDiv;
  final List<String> _semesters = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];
  final List<String> _branches = [
    'AI & ML',
    'Civil',
    'Chemical',
    'Computer Science',
    'Electrical',
    'Electronics & Communication',
    'Mechanical',
  ];
  final List<String> _divisions = ['A', 'B'];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Positioned(
            top: -200,
            right: 60,
            child: Image.asset(
              "assets/images/gradients/Group 1.png",
              fit: BoxFit.cover,
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
                    horizontal: SizeConfig.screenWidth * 0.05, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: width * 0.3,
                    ),
                    Text(
                      'Hello There!',
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to Campus Buddy",
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Create an account",
                          style: GoogleFonts.poppins(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: width * 0.05,
                    ),
                    Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Name',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                          MyTextField(
                            controller: _nameController,
                            hint: 'Enter your name',
                            obscure: false,
                            selection: true,
                            preIcon: Icons.person_outlined,
                            validator: (name) {
                              if (name!.isEmpty)
                                return "Please enter name";
                              else if (!RegExp(
                                      r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                                  .hasMatch(name)) {
                                return "Please Enter first name and last name";
                              }
                            },
                            keyboardtype: TextInputType.name,
                          ),
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
                            autofillhints: [AutofillHints.email],
                            controller: _emailController,
                            hint: 'Enter your email',
                            obscure: false,
                            selection: true,
                            preIcon: Icons.email_outlined,
                            validator: (email) {
                              if (email!.isEmpty)
                                return "Please enter email";
                              else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0.9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0.9]+\.[a-zA-Z]+",
                              ).hasMatch(email)) {
                                return "Please Enter a valid email";
                              }
                            },
                            keyboardtype: TextInputType.emailAddress,
                          ),
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
                            controller: _passwordController,
                            hint: 'Enter password',
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
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Confirm Password',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                          MyTextField(
                            controller: _confirmPasswordController,
                            hint: 'Enter your password again',
                            obscure: true,
                            selection: false,
                            preIcon: Icons.password_outlined,
                            suffixIcon: Icons.abc,
                            validator: (confirmPassword) {
                              if (confirmPassword!.isEmpty) {
                                return "Please confirm the password";
                              } else if (confirmPassword !=
                                  _passwordController.text) {
                                return "Passwords do not match";
                              }
                            },
                            keyboardtype: TextInputType.emailAddress,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'USN',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.04,
                              ),
                            ),
                          ),
                          // Dropdown for Semesters
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.01,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Select Branch',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                            ),
                            isExpanded: true,
                            value: _selectedBrnach,
                            items: _branches.map((String branch) {
                              return DropdownMenuItem<String>(
                                value: branch,
                                child: Text(branch),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedBrnach = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a branch';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.03,
                          ),
                          Row(
                            children: [
                              // Dropdown for Semester
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Select Semester',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                  ),
                                  isExpanded: true,
                                  value: _selectedSem,
                                  items: _semesters.map((String sem) {
                                    return DropdownMenuItem<String>(
                                      value: sem,
                                      child: Text(sem),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedSem = newValue;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a semester';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                  width: 16), // Add space between the dropdowns
// Dropdown for Division
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Select Division',
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                  ),
                                  isExpanded: true,
                                  value: _selectedDiv,
                                  items: _divisions.map((String div) {
                                    return DropdownMenuItem<String>(
                                      value: div,
                                      child: Text(div),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedDiv = newValue;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a division';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: width * 0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //Sign in Button
                              MyButton(
                                  onTap: () async {
                                    await signup(context);
                                  },
                                  text: 'Sign Up',
                                  color: Theme.of(context).colorScheme.primary),
                              SizedBox(
                                height: width * 0.05,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
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
                                            builder: (context) => LoginPage()),
                                      );
                                    },
                                    child: Text(
                                      'Log in',
                                      style: GoogleFonts.poppins(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600,
                                        fontSize: width * 0.04,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

  Future<void> signup(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      // Ensure the form is valid
      try {
        // Call the signUpWithEmailPassword method from AuthService
        await _authService.signUpWithEmailPassword(
            _emailController.text.trim(),
            _passwordController.text.trim(),
            _nameController.text.trim(),
            int.parse(_selectedSem!),
            _selectedDiv!,
            _selectedBrnach!);

        // Navigate to the HomePage on successful signup
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EmailNotVerifiedPage(email: _emailController.text)),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
                e.toString().replaceFirst('Exception: ', '').toUpperCase()),
          ),
        );
      }
    }
  }
}

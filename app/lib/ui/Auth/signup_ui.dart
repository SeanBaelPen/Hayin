import 'package:app/services/AuthService.dart';
import 'package:app/services/FirestoreService.dart';
import 'package:app/ui/Profile/ProfileView.dart';
import 'package:app/ui/home_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:app/ui/Auth/welcome_ui.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  String? _passwordError;
  String? _emailError;
  bool _passwordVisible = false;

  void _register() async {
    if (!_validatePassword(_passwordController.text)) {
      Fluttertoast.showToast(
          msg:
              "Password must be at least 8 characters long and contain at least one number and one special character.");
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      Fluttertoast.showToast(msg: "Passwords do not match.");
      return;
    }

    bool authRequest = await AuthService()
        .signUp(_emailController.text, _passwordController.text);

    if (authRequest == true) {
      // Add the user email, firstName, and lastName to Firestore
      FirestoreService()
          .createUser(_firstNameController.text, _lastNameController.text);
      _clearTextFields(); // Clear the text fields

      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return const HomePage();
        }),
      );
    } else {
      Fluttertoast.showToast(msg: "Error creating account.");
    }
  }

  void _clearTextFields() {
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    final passwordRegex =
        RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/signUpBackground.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const WelcomePage();
                          }),
                        );
                        print('Icon btn is tapped');
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 45),
                    child: const Text(
                      'Create \nAccount',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(top: 20),
                    width: 345,
                    height: 435,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: TextField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your first name',
                              isCollapsed: true,
                              labelStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: TextField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your last name',
                              isCollapsed: true,
                              labelStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              isCollapsed: true,
                              labelStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              isCollapsed: true,
                              hintText: 'Enter your password',
                              labelStyle: TextStyle(fontSize: 18),
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                child: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: TextField(
                            controller: _confirmPasswordController,
                            obscureText: !_passwordVisible,
                            decoration: const InputDecoration(
                              hintText: 'Confirm your password',
                              isCollapsed: true,
                              labelStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (!_validateEmail(_emailController.text)) {
                                  setState(() {
                                    _emailError = "Invalid email address.";
                                  });
                                  return;
                                }
                                if (_passwordController.text !=
                                    _confirmPasswordController.text) {
                                  setState(() {
                                    _passwordError = "Passwords do not match.";
                                  });
                                  return;
                                }
                                _register();
                              },
                              child: Container(
                                child: Image.asset(
                                  'assets/signUpButton.png',
                                  width: 200,
                                  height: 130,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_passwordError != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              _passwordError!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        if (_emailError != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              _emailError!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfilePage()),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

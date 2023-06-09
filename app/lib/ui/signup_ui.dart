import 'package:app/ui/welcome_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_ui.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  late bool _success;
  late String _userEmail;
  String? _passwordError;

  void _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _passwordError = "Passwords do not match.";
      });
      return;
    }

    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email!;
        _passwordError = null; // Reset the password error message
      });
      _clearTextFields(); // Clear the text fields
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  void _clearTextFields() {
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/signUpBackground.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
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
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 45, top: 20),
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
                  margin: EdgeInsets.only(top: 50),
                  width: 345,
                  height: 443,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                        ),
                        obscureText: true,
                      ),
                      TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          hintText: 'Confirm your password',
                        ),
                        obscureText: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
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
                                height: 200,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_passwordError != null)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            _passwordError!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      //const Text('Already have an account? Login'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: const Text("Login"),
                          )
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
    );
  }
}

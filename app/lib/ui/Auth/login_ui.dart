import 'package:app/ui/Auth/welcome_ui.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _success = 1;
  String _userEmail = "";
  bool _passwordVisible = false;

  void _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _success = 3; // Email or password is empty
      });
      return;
    }

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        setState(() {
          _success = 2; // Login is successful
          _userEmail = user.email!;
        });
      } else {
        setState(() {
          _success = 3; // Email or password doesn't match
        });
      }
    } catch (e) {
      print('Error signing in: $e');
      setState(() {
        _success = 3; // Email or password doesn't match
      });
    }
  }

  void _resetPassword() async {
    String email = _emailController.text;

    try {
      await _auth.sendPasswordResetEmail(email: email);
      setState(() {
        _success = 4; // Password reset email sent successfully
      });
    } catch (e) {
      print('Error sending password reset email: $e');
      setState(() {
        _success = 5; // Password reset email sending failed
      });
    }
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
                  margin: const EdgeInsets.only(left: 45, top: 20),
                  child: const Text(
                    'Welcome \nBack',
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
                  margin: const EdgeInsets.only(top: 50),
                  width: 345,
                  height: 443,
                  color: Colors.white,
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              _login();
                            },
                            child: Container(
                              child: Image.asset(
                                'assets/logInButton.png',
                                width: 200,
                                height: 200,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              _resetPassword();
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Text('Forgot Password?'),
                      Visibility(
                        visible: _success == 2,
                        child: Text(
                          'Successfully signed in $_userEmail',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                      Visibility(
                        visible: _success == 4,
                        child: const Text(
                          'Password reset email sent successfully',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      Visibility(
                        visible: _success == 5,
                        child: const Text(
                          'Failed to send password reset email',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Visibility(
                        visible: _success == 3,
                        child: const Text(
                          'Incorrect email or password',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
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

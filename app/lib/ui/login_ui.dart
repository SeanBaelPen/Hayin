import 'package:app/ui/welcome_ui.dart';
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

  void _login() async {
    final User? user = (await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;

    if (user != null) {
      setState(() {
        _success = 2; //means the login is successful
        _userEmail = user.email!;
      });
    } else {
      setState(() {
        _success = 3;
      });
    }
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
                  margin: EdgeInsets.only(top: 50),
                  width: 345,
                  height: 443,
                  color: Colors.white,
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
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Image.asset(
                      //       'assets/logInButton.png',
                      //       width: 200,
                      //       height: 200,
                      //     ),
                      //   ],
                      // ),
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
                      Text('Forgot Password?'),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: _success == 2,
              child: Text(
                'Successfully signed in $_userEmail',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

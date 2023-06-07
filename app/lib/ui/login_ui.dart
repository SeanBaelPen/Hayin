import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              children: const [
                Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 50,
                  color: Colors.white,
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
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logInButton.png',
                            width: 200,
                            height: 200,
                          ),
                        ],
                      ),
                      Text('Forgot Password?'),
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

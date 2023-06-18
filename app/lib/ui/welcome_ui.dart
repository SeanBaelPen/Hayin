import 'package:app/ui/signup_ui.dart';
import 'package:flutter/material.dart';
// import 'filter_ui.dart';
import 'login_ui.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcomebg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 500,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const LoginPage();
                    }),
                  );
                  print('Login button tapped');
                },
                child: Image.asset(
                  'assets/logInButton.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Positioned(
              top: 580,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const SignUpPage();
                    }),
                  );
                  print('Sign-up button tapped');
                },
                child: Image.asset(
                  'assets/signUpButton.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

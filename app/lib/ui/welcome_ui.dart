import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcomebg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        // child: Row(
        //   children: [
        //     InkWell(
        //       onTap: () {
        //         // Define the action you want to perform when the button/photo is tapped
        //         print('Button tapped');
        //       },
        //       child: Image.asset(
        //         'assets/logInButton.png',
        //         width: 200,
        //         height: 200,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

import 'package:app/services/AuthService.dart';
import 'package:app/ui/Auth/welcome_ui.dart';
import 'package:app/ui/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ViewModels/authViewModel.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    var authState = ref.watch(authStateProvider);

    return Scaffold(
      body: authState.when(data: (data) {
        if (data?.uid != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          });
        }
        return Container(
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
                                AuthService().signIn(_emailController.text,
                                    _passwordController.text);
                              },
                              child: Image.asset(
                                'assets/logInButton.png',
                                width: 200,
                                height: 200,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                AuthService()
                                    .resetPassword(_emailController.text);
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
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }, error: (error, stack) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

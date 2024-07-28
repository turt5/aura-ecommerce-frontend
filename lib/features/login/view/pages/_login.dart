import 'dart:math';

import 'package:attira/features/splash/view/widgets/_logo.dart';
import 'package:attira/features/login/view/widgets/_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../register/view/pages/_register.dart';
import '../widgets/_email_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: theme.surface,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AttiraLogo(theme: theme, fontSize: 20, iconSize: 22),
                ],
              )),
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                Text("Login with your email and password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: theme.onSurface,
                    )),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: EmailField(
                    emailController: emailController,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: PasswordField(
                    passwordController: passController,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primary,
                      foregroundColor: theme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "New here?",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          'Create a new account',
                          style: TextStyle(
                              fontSize: 13,
                              color: theme.secondary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text('Forgot Password?',
                //         style: TextStyle(
                //           fontSize: 13,
                //           color: Colors.grey,
                //         )),
                //     TextButton(
                //       onPressed: () {},
                //       child: Text(
                //         'Reset',
                //         style: TextStyle(
                //             fontSize: 13,
                //             color: theme.secondary,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
}

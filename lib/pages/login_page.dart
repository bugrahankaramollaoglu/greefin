import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:greefin/pages/register_form.dart';

import 'login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage;
  bool showLoginPage = true; // Control state for page transition

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/1.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              height: 1000,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    height: 700,
                    width: 375,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white60, Colors.white10],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        width: 2,
                        color: Colors.black87.withOpacity(0.4),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: showLoginPage ? LoginForm() : RegisterForm(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

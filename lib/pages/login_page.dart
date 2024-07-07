import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:greefin/pages/login_register_forms/register_form.dart';

import '../utilities/my_colors.dart';
import 'login_register_forms/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage;
  bool showLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Container(
          width: 350,
          height: 700,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.grey.withOpacity(0.7), Colors.white],
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey, // Choose your stroke color here
                    width: 2, // Adjust the width of the border
                  ),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/avatar6.png'),
                  // Add onTap to allow user to change profile picture
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

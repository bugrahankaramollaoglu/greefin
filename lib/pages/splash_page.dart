import 'dart:async';

import 'package:flutter/material.dart';
import 'package:greefin/main.dart';
import 'package:greefin/pages/login_forms/login_form.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _mockCheckForSession().then((status) {
      if (status) {
        _navigateToHome();
      }
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(
        Duration(seconds: 3), () {}); // Simulate a long wait time
    return true; // Replace with your actual logic
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => GreefinApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
            'assets/splash.png'), // Replace with your splash screen image
      ),
    );
  }
}

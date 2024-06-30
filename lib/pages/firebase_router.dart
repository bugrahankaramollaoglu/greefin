import 'package:flutter/material.dart';
import 'package:greefin/deneme.dart';
import 'package:greefin/pages/auth.dart';
import 'package:greefin/onboarding.dart';
import 'package:greefin/pages/home_page.dart';
import 'package:greefin/pages/login_page.dart';

class FirebaseRouter extends StatefulWidget {
  const FirebaseRouter({super.key});

  @override
  State<FirebaseRouter> createState() => _FirebaseRouterState();
}

class _FirebaseRouterState extends State<FirebaseRouter> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          return HomePage();
        }
        return const LoginPage();
      },
    );
  }
}

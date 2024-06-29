import 'package:flutter/cupertino.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/firebase/login_page.dart';
import 'package:greefin/onboarding.dart';

class FirebaseAuth extends StatefulWidget {
  const FirebaseAuth({super.key});

  @override
  State<FirebaseAuth> createState() => _FirebaseAuthState();
}

class _FirebaseAuthState extends State<FirebaseAuth> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const OnboardingScreen();
          // return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greefin/firebase/firebase_options.dart';
import 'package:greefin/firebase/firebase_router.dart';
import 'package:greefin/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_colors.dart';

MyColors my_colors = MyColors();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: GreefinApp(),
    ),
  );
}

class GreefinApp extends StatefulWidget {
  const GreefinApp({super.key});

  @override
  State<GreefinApp> createState() => _GreefinAppState();
}

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

class _GreefinAppState extends State<GreefinApp> {
  bool _isOnboardingCompleted = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOnboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: my_colors.color6,
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: my_colors.color6,
        body: _isOnboardingCompleted
            ? const FirebaseRouter()
            : const OnboardingPage(),
      ),
    );
  }
}

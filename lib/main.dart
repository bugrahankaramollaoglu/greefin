// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:greefin/firebase/firebase_options.dart';
import 'package:greefin/home_page.dart';
import 'package:greefin/onboarding.dart';
import 'package:greefin/shared_preferences.dart';

import 'firebase/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GreefinApp());
}

class GreefinApp extends StatefulWidget {
  const GreefinApp({super.key});

  @override
  State<GreefinApp> createState() => _GreefinAppState();
}

class _GreefinAppState extends State<GreefinApp> {
  bool _isOpenedBefore = false;

  @override
  void initState() {
    super.initState();
    _loadIsOpenedStatus();
  }

  Future<void> _loadIsOpenedStatus() async {
    final isOpened = await loadIsOpened('isOpenedBefore');
    setState(() {
      _isOpenedBefore = isOpened ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: _isOpenedBefore ? FirebaseAuth() : OnboardingScreen(),
    );
  }
}

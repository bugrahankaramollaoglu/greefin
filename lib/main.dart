import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:greefin/firebase/firebase_options.dart';
import 'package:greefin/firebase/login_page.dart';
import 'package:greefin/home_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const FirebaseAuth(),
    );
  }
}

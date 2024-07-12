import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greefin/firebase/firebase_options.dart';
import 'package:greefin/firebase/firebase_router.dart';
import 'package:greefin/pages/home_page.dart';
import 'package:greefin/pages/navigation_pages/add_page.dart';
import 'package:greefin/pages/navigation_pages/green_page/carbon_footprint.dart';
import 'package:greefin/pages/navigation_pages/green_page/green_map.dart';
import 'package:greefin/pages/navigation_pages/green_page/green_page.dart';
import 'package:greefin/pages/navigation_pages/main_page.dart';
import 'package:greefin/pages/navigation_pages/profile_page.dart';
import 'package:greefin/pages/navigation_pages/stats_page.dart';
import 'package:greefin/pages/onboarding_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOnboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomePage(),
        '/main': (context) => const MainPage(),
        '/green': (context) => const GreenPage(),
        '/add': (context) => const AddPage(),
        '/stats': (context) => const StatsPage(),
        '/profile': (context) => const ProfilePage(),
        '/green_map': (context) => GreenMap(),
        '/carbon_footprint': (context) => const CarbonFootprint(),
      },
      home: _isOnboardingCompleted
          ? const FirebaseRouter()
          : const OnboardingPage(),
    );
  }
}

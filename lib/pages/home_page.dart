import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greefin/bottom_navigation.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/pages/add_page.dart';
import 'package:greefin/pages/green_page.dart';
import 'package:greefin/pages/login_page.dart';
import 'package:greefin/pages/main_page.dart';
import 'package:greefin/pages/profile_page.dart';
import 'package:greefin/pages/stats_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth _auth = Auth();
  User? user;
  int _selectedIndex = 0;

  static const List<Widget> _bottomPages = <Widget>[
    MainPage(),
    StatsPage(),
    AddPage(),
    GreenPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges.listen((User? user) {
      setState(() {
        this.user = user;
      });
      if (user == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: _bottomPages.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

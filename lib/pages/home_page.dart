import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greefin/bottom_navigation.dart';
import 'package:greefin/pages/auth.dart';
import 'package:greefin/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth _auth = Auth();
  User? user;
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Search Page'),
    Text('Profile Page'),
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
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          ElevatedButton(
            onPressed: () {
              _auth.signOut();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}

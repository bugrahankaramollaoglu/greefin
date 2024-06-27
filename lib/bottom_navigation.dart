import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greefin/firebase/login_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Screen'),
    Text('Track Screen'),
    Text('Camera Screen'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 1) {
      _signOut().then((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    } else if (_selectedIndex == 2) {
      Navigator.pushNamed(context, '/track');
    } else if (_selectedIndex == 3) {
      Navigator.pushNamed(context, '/track');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      backgroundColor: Colors.white.withOpacity(0.3),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      selectedFontSize: 20,
      elevation: 20,
      onTap: _onItemTapped, // Assign the callback function
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money),
          label: 'track',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: 'camera',
        ),
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.1, 0, size.width * 0.2, 0);
    path.lineTo(size.width * 0.8, 0);
    path.quadraticBezierTo(size.width * 0.9, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

/*  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Screen'),
    Text('Profile Screen'),
    Text('Notifications Screen'),
    Text('Settings Screen'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                height: 80,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home,
                          color: _selectedIndex == 0
                              ? Colors.white
                              : Colors.black),
                      onPressed: () => _onItemTapped(0),
                    ),
                    IconButton(
                      icon: Icon(Icons.person,
                          color: _selectedIndex == 1
                              ? Colors.white
                              : Colors.black),
                      onPressed: () => _onItemTapped(1),
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications,
                          color: _selectedIndex == 2
                              ? Colors.white
                              : Colors.black),
                      onPressed: () => _onItemTapped(2),
                    ),
                    IconButton(
                      icon: Icon(Icons.settings,
                          color: _selectedIndex == 3
                              ? Colors.white
                              : Colors.black),
                      onPressed: () => _onItemTapped(3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


*/

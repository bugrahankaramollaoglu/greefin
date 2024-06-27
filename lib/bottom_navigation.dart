import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:greefin/firebase/login_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

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
      // Navigator.pushNamed(context, '/track');
      // Get.to(() => LoginPage());
      // Get.offAll(() => FirebaseAuthPage());
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

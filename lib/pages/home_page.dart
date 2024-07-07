import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greefin/deneme.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/my_colors.dart';
import 'package:greefin/pages/add_page.dart';
import 'package:greefin/pages/green_page.dart';
import 'package:greefin/pages/login_page.dart';
import 'package:greefin/pages/main_page.dart';
import 'package:greefin/pages/profile_page.dart';
import 'package:greefin/pages/stats_page.dart';
import 'package:iconly/iconly.dart';

enum _SelectedTab { main, stats, add, green, profile }

MyColors my_colors = MyColors();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth _auth = Auth();
  User? user;
  var _selectedTab = _SelectedTab.main;

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedTab = _SelectedTab.values[index];
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
        WidgetsBinding.instance!.addPostFrameCallback((_) {
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
      extendBody: true,
      backgroundColor: my_colors.color6,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _buildBody(),
      ),
      bottomNavigationBar: CrystalNavigationBar(
        duration: Duration(milliseconds: 500),
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        height: 50,
        borderRadius: 15,
        splashBorderRadius: 15,
        outlineBorderColor: Colors.white,
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.black.withOpacity(0.9),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: _handleIndexChanged,
        enablePaddingAnimation: true,
        items: [
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            selectedColor: Colors.white,
            unselectedIcon: IconlyLight.home,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.heart,
            selectedColor: Colors.white,
            unselectedIcon: IconlyLight.heart,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.plus,
            selectedColor: Colors.white,
            unselectedIcon: IconlyLight.plus,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.search,
            selectedColor: Colors.white,
            unselectedIcon: IconlyLight.search,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.profile,
            selectedColor: Colors.white,
            unselectedIcon: IconlyLight.profile,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedTab) {
      case _SelectedTab.main:
        return MainPage();
      case _SelectedTab.stats:
        return StatsPage();
      case _SelectedTab.add:
        return AddPage();
      case _SelectedTab.green:
        return GreenPage();
      case _SelectedTab.profile:
        return ProfilePage();
    }
  }
}

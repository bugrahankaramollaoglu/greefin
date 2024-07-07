import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/utilities/my_colors.dart';
import 'package:greefin/pages/login_page.dart';
import 'package:greefin/pages/navigation_pages/main_page.dart';
import 'package:greefin/pages/navigation_pages/profile_page.dart';
import 'package:greefin/pages/navigation_pages/search_page.dart';
import 'package:greefin/pages/navigation_pages/stats_page.dart';
import 'package:iconly/iconly.dart';

import 'navigation_pages/add_page.dart';

enum _SelectedTab { main, search, add, stats, profile }

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
      appBar: AppBar(
        centerTitle: true,
        title: Text('page Name'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {},
            child: Icon(
              Icons.arrow_back,
              color: my_colors.color6,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: my_colors.color7,
              // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                // side: BorderSide(color: my_colors.color5,width: 1),
              ),
              elevation: 50,

              padding: EdgeInsets.zero,
              // Remove default padding
              // Remove minimum size constraints
              alignment: Alignment.center, // Center the content
            ),
          ),
        ),
      ),
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
        backgroundColor: my_colors.color5.withOpacity(0.9),
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
            icon: IconlyBold.search,
            selectedColor: Colors.white,
            unselectedIcon: IconlyLight.search,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.plus,
            selectedColor: Colors.white,
            unselectedIcon: IconlyLight.plus,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.chart,
            selectedColor: Colors.white,
            unselectedIcon: IconlyLight.chart,
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
      case _SelectedTab.search:
        return SearchPage();
      case _SelectedTab.add:
        return AddPage();
      case _SelectedTab.stats:
        return StatsPage();
      case _SelectedTab.profile:
        return ProfilePage();
    }
  }
}

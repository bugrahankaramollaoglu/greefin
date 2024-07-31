import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/pages/navigation_pages/add_purchase.dart';
import 'package:greefin/pages/navigation_pages/main_page.dart';
import 'package:greefin/utilities/my_colors.dart';
import 'package:greefin/pages/login_page.dart';
import 'package:greefin/pages/navigation_pages/profile_page.dart';
import 'package:greefin/pages/navigation_pages/green_page/green_page.dart';
import 'package:greefin/pages/navigation_pages/stats_page.dart';
import 'package:iconly/iconly.dart';

enum _SelectedTab { main, green, add, stats, profile }

MyColors my_colors = MyColors();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
      extendBody: true,
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _buildBody(),
      ),
      bottomNavigationBar: CrystalNavigationBar(
        duration: const Duration(milliseconds: 500),
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        height: 50,
        borderRadius: 15,
        splashBorderRadius: 15,
        // outlineBorderColor: Colors.white,
        indicatorColor: MyColors().color9,
        backgroundColor: Colors.transparent,
        selectedItemColor: MyColors().color9,
        unselectedItemColor: Colors.grey,
        onTap: _handleIndexChanged,
        enablePaddingAnimation: false,
        items: [
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            unselectedIcon: IconlyLight.home,
          ),
          CrystalNavigationBarItem(
            icon: Icons.energy_savings_leaf,
            unselectedIcon: Icons.energy_savings_leaf_outlined,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.plus,
            unselectedIcon: IconlyLight.plus,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.chart,
            unselectedIcon: IconlyLight.chart,
          ),
          CrystalNavigationBarItem(
            icon: IconlyBold.profile,
            unselectedIcon: IconlyLight.profile,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedTab) {
      case _SelectedTab.main:
        return  MainPage();
      case _SelectedTab.green:
        return const GreenPage();
      case _SelectedTab.add:
        return const AddPurchase();
      case _SelectedTab.stats:
        return const StatsPage();
      case _SelectedTab.profile:
        return ProfilePage();
    }
  }
}

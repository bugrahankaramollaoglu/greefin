import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

Widget _profileRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 30,
      ),
      Text('Settings', style: TextStyle(fontSize: 33)),
      Icon(
        Icons.notifications,
        size: 30,
      ),
    ],
  );
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // _profileRow(),
          ],
        ),
      ),
    );
  }
}

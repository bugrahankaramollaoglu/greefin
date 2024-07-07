import 'package:flutter/material.dart';
import 'package:greefin/my_colors.dart';

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
        size: 20,
      ),
      Text('Profile', style: TextStyle(fontSize: 33)),
      Icon(
        Icons.notifications,
        size: 20,
      ),
    ],
  );
}

class _ProfilePageState extends State<ProfilePage> {

  MyColors colors = MyColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: _profileRow(),
            ),
          ],
        ),
      ),
    );
  }
}

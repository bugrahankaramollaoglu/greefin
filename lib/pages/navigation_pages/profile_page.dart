import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/utilities/my_colors.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  User? user = FirebaseAuth.instance.currentUser;
  String? user_name;

  @override
  Widget build(BuildContext context) {
    user_name = user?.email!.split('@')[0];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: MyColors().color8.withOpacity(0.2),
                  width: 8,
                ),
              ),
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/avatar6.png'),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        const Color.fromARGB(255, 111, 107, 107).withOpacity(1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: user_name,
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        const Color.fromARGB(255, 111, 107, 107).withOpacity(1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: user!.email ?? 'unknown@hotmail.com',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors().color9,
                elevation: 12,
                shadowColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Auth().signOut();
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text(
                'Sign Out',
                style: TextStyle(
                  color: MyColors().color6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/utilities/my_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        centerTitle: true,
        title: Text('PROFİLE'),
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_rounded),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ), */
      body: Column(
        children: [
          SizedBox(height: 100),
          Center(
            child: Text(
              'Please set up your profile',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.grey.withOpacity(0.8),
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(2),
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
            padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Name',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 111, 107, 107).withOpacity(1),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'John Doe',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 111, 107, 107).withOpacity(1),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'bugrakaramollaoglu@hotmail.com',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors().color9,
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
    );
  }
}

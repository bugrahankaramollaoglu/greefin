import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/utilities/my_colors.dart';
import '../../firebase/auth.dart';
import 'editmyprofile_page.dart';
import 'changepassword_page.dart';
import 'change_avatar_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  String? user_name;

  @override
  Widget build(BuildContext context) {
    user_name = user?.displayName ?? user?.email!.split('@')[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MyColors().color8.withOpacity(0.2),
                    width: 8,
                  ),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user?.photoURL ?? 'assets/avatar6.png'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              user_name ?? 'Unknown User',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user?.email ?? 'unknown@hotmail.com',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 20),
            _buildButton(
              icon: Icons.edit,
              label: 'Edit My Profile',
              onTap: () async {
                final updatedUserName = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                );

                if (updatedUserName != null) {
                  setState(() {
                    user_name = updatedUserName;
                    user = FirebaseAuth.instance.currentUser;
                  });
                }
              },
            ),
            _buildButton(
              icon: Icons.photo_camera,
              label: 'Change Avatar',
              onTap: () async {
                final newAvatar = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeAvatarPage(),
                  ),
                );
                if (newAvatar != null) {
                  setState(() {
                    user = FirebaseAuth.instance.currentUser;
                  });
                }
              },
            ),
            _buildButton(
              icon: Icons.lock,
              label: 'Change Password',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePasswordPage(),
                  ),
                );
              },
            ),
            _buildButton(
              icon: Icons.logout,
              label: 'Log Out',
              onTap: () {
                _showSignOutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          shadowColor: Colors.greenAccent,
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.green, width: 2),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Auth().signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}

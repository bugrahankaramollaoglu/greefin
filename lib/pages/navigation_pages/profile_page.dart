import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greefin/main.dart';
import 'package:greefin/my_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  MyColors myColors = MyColors();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _nameController.text = _user?.displayName ?? '';
    _phoneController.text = _user?.phoneNumber ?? '';
    // Set default location based on user's data or leave it empty
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: MyColors().color8, // Choose your stroke color here
                width: 4, // Adjust the width of the border
              ),
            ),
            child: CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage('assets/avatar6.png'),
              // Add onTap to allow user to change profile picture
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Logged in as:',
            style: TextStyle(
              fontSize: 18,
              color: myColors.color6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _user?.email ?? 'error',
            style: TextStyle(
              fontSize: 16,
              color: myColors.color1,
            ),
          ),
          SizedBox(height: 32),
          _buildProfileInfoItem(
            icon: Icons.person,
            label: 'Name',
            controller: _nameController,
          ),
          SizedBox(height: 12),
          _buildProfileInfoItem(
            icon: Icons.phone,
            label: 'Phone',
            controller: _phoneController,
          ),
          SizedBox(height: 12),
          _buildProfileInfoItem(
            icon: Icons.location_on,
            label: 'Location',
            controller: _locationController,
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Implement save profile logic here
            },
            child: Text('Save'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: myColors.color7, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfoItem({
    required IconData icon,
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: myColors.color4,
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

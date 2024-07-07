import 'package:flutter/material.dart';
import 'package:greefin/my_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          Center(
            child: CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage('assets/avatar6.png'),
              // Add onTap to allow user to change profile picture

            ),
          ),
          SizedBox(height: 16),
          Text(
            _user?.email ?? '',
            style: TextStyle(
              fontSize: 18,
              color: myColors.color6, // Email text color
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
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16), backgroundColor: myColors.color1, // Customize button color
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
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: myColors.color4, // Icon color
        ),
        SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greefin/utilities/my_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  MyColors myColors = MyColors();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: MyColors().color8, // Choose your stroke color here
                width: 4, // Adjust the width of the border
              ),
            ),
            child: const CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage('assets/avatar6.png'),
              // Add onTap to allow user to change profile picture
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Logged in as:',
            style: TextStyle(
              fontSize: 18,
              color: myColors.color6,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _user?.email ?? 'error',
            style: TextStyle(
              fontSize: 16,
              color: myColors.color1,
            ),
          ),
          const SizedBox(height: 32),
          _buildProfileInfoItem(
            icon: Icons.person,
            label: 'Name',
            controller: _nameController,
          ),
          const SizedBox(height: 12),
          _buildProfileInfoItem(
            icon: Icons.phone,
            label: 'Phone',
            controller: _phoneController,
          ),
          const SizedBox(height: 12),
          _buildProfileInfoItem(
            icon: Icons.location_on,
            label: 'Location',
            controller: _locationController,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Implement save profile logic here
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: myColors.color7, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Save'),
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
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(fontSize: 16),
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

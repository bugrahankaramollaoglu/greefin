import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greefin/utilities/my_colors.dart';
import '../../login_page.dart';


class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User? user;
  String? userName;

  
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    userName = user?.displayName ?? user?.email?.split('@')[0];
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New password and confirm password do not match')),
        );
        return; 
      }

      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: _currentPasswordController.text,
        );

        await user!.reauthenticateWithCredential(credential);
        
        await user!.updatePassword(_newPasswordController.text);
        
        await FirebaseAuth.instance.signOut();
        
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()), // Login sayfasına yönlendirme
              (route) => false,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password changed successfully. Please log in again.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to change password: ${e.toString()}')),
        );
      }
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold), // Başlığı kalın yap
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user?.photoURL ?? 'assets/avatar6.png'),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                userName ?? 'Unknown User',
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
              const SizedBox(height: 30),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPasswordField(
                    controller: _currentPasswordController,
                    label: 'Current Password',
                    obscureText: _obscureCurrentPassword,
                    onToggle: () => setState(() {
                      _obscureCurrentPassword = !_obscureCurrentPassword;
                    }),
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(
                    controller: _newPasswordController,
                    label: 'New Password',
                    obscureText: _obscureNewPassword,
                    onToggle: () => setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    }),
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    label: 'Confirm New Password',
                    obscureText: _obscureConfirmPassword,
                    onToggle: () => setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    }),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: 380, 
                        child: ElevatedButton(
                          onPressed: _changePassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors().color8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            shadowColor: Colors.greenAccent,
                            minimumSize: const Size(double.infinity, 48), 
                          ),
                          child: const Text(
                            'Change Password',
                            style: TextStyle(fontSize: 20, color: Colors.white), 
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30), 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: 380, 
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: onToggle,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $label';
            }
            if (label == 'Confirm New Password' && value != _newPasswordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auth_button_kit/auth_button_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/pages/home_page.dart';
import 'package:greefin/pages/register_form.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? errorMessage;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> _createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
    IconData icon,
    bool isPassword,
  ) {
    return TextField(
      style: TextStyle(color: Colors.black54),
      cursorColor: Colors.black54,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        prefixIcon: Icon(icon),
        hintText: 'Enter',
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Unfocused border color
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Focused border color
        ),
        labelText: title,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget errorMessageWidget() {
    if (errorMessage != null) {
      return Text(
        errorMessage!,
        style: const TextStyle(color: Colors.red),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _loginButton() {
    return AuthButton(
      onPressed: (method) => _signInWithEmailAndPassword(),
      brand: Method.custom,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      text: 'Login',
      customImage: Image.asset('assets/signin.png'),
      backgroundColor: Colors.green,
      textColor: Colors.black54,
    );
  }

  Widget _registerButton() {
    return AuthButton(
      onPressed: (asd){},
      // onPressed: (method) => setState(() => showLoginPage = false),
      brand: Method.custom,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      text: 'Register',
      customImage: Image.asset('assets/signup.png'),
      backgroundColor: const Color.fromARGB(255, 200, 200, 31),
      textColor: Colors.black54,
    );
  }

  Widget _registerUserButton() {
    return AuthButton(
      onPressed: (method) => _createUserWithEmailAndPassword(),
      brand: Method.custom,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      text: 'Create User',
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }

  Widget _guestButton() {
    return AuthButton(
      onPressed: (method) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      brand: Method.custom,
      text: 'Continue as Guest',
    );
  }

  Future<void> _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
          );
        }
      } else {
        print('aa: not worked');
      }
    } catch (e) {
      print('aa: Error: $e');
    }
  }

  // Forgot Password Functionality
  Widget _forgotPassword() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () => _showForgotPasswordDialog(context),
        // Use a method to show the dialog
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    TextEditingController _emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Forgot Password?'),
          content: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Enter your email',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Reset Password'),
              onPressed: () async {
                Navigator.pop(context); // Close the dialog
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                    email: _emailController.text.trim(),
                  );

                  // Check if the context is still valid before showing SnackBar
                  if (ScaffoldMessenger.of(context).mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password reset email sent.'),
                        duration: Duration(seconds: 5),
                      ),
                    );
                  }
                } catch (e) {
                  print('Error sending password reset email: $e');
                  // Check if the context is still valid before showing SnackBar
                  if (ScaffoldMessenger.of(context).mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to send reset email. Please try again later.',
                        ),
                        duration: Duration(seconds: 5),
                      ),
                    );
                  }
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Widget _oauthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: _signInWithGoogle,
            icon: const Icon(
              FontAwesomeIcons.google,
              color: Colors.black87,
              size: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: _signInWithGoogle,
            icon: const Icon(
              FontAwesomeIcons.microsoft,
              color: Colors.black87,
              size: 35,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: _signInWithGoogle,
            icon: const Icon(
              FontAwesomeIcons.apple,
              color: Colors.black87,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return SizedBox(
      child: Image.asset('assets/or.png'),
      width: 300,
      height: 75,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('loginPage'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'GREEFIN',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _entryField(
          'Email',
          _emailController,
          Icons.email,
          false,
        ),
        const SizedBox(height: 20),
        _entryField(
          'Password',
          _passwordController,
          Icons.lock,
          true,
        ),
        _forgotPassword(), // Forgot password button
        errorMessageWidget(),
        const SizedBox(height: 20),
        _loginButton(),
        _registerButton(),
        _guestButton(),
        const SizedBox(height: 30),
        _divider(),
        const SizedBox(height: 10),
        _oauthRow(),
      ],
    );
  }
}

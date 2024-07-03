import 'dart:ui';

import 'package:auth_button_kit/auth_button_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/onboarding.dart';
import 'package:greefin/pages/home_page.dart';
import 'package:neumorphic_button/neumorphic_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: title,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
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
        borderRadius: BorderRadius.circular(5),
      ),
      customImage: Image.asset('assets/signin.png'),
      text: 'Login',
      backgroundColor: Colors.green,
      textColor: Colors.black54,
    );
  }

  Widget _registerButton() {
    return AuthButton(
      onPressed: (method) => _createUserWithEmailAndPassword(),
      brand: Method.custom,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      customImage: Image.asset('assets/signup.png'),
      text: 'Register',
      backgroundColor: Colors.blue,
      textColor: Colors.black54,
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
        borderRadius: BorderRadius.circular(5),
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
        // _showToast('Google Sign-In canceled.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget _forgotPassword() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          // Add forgot password functionality here
        },
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 16,
          ),
        ),
      ),
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
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/leaf2.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.5)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: 700,
                  width: 350,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white60, Colors.white10],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      width: 2,
                      color: Colors.black87.withOpacity(0.4),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'GREEFIN',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        _entryField(
                            'Email', _emailController, Icons.email, false),
                        const SizedBox(height: 20),
                        _entryField(
                            'Password', _passwordController, Icons.lock, true),
                        _forgotPassword(),
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
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

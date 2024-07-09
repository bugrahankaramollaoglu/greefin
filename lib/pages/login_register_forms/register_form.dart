import 'package:auth_button_kit/auth_button_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/pages/home_page.dart';
import 'package:greefin/pages/riverpod_providers.dart';
import 'package:greefin/utilities/my_colors.dart';
import 'package:text_divider/text_divider.dart';

class RegisterForm extends ConsumerWidget {
  RegisterForm({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget nameField(
      String hintText, TextEditingController controller, IconData icon) {
    return TextFormField(
      keyboardType: TextInputType.name,
      autocorrect: false,
      cursorColor: Colors.grey,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        prefixIcon: Icon(icon),
        labelText: hintText,
        hintText: 'Enter',
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $hintText";
        }
        return null;
      },
    );
  }

  Widget _backToLoginButton() {
    return AuthButton(
      onPressed: (method) {},
      brand: Method.custom,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      text: 'Back to Login',
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }

  Widget emailField(
      String hintText, TextEditingController controller, IconData icon) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      cursorColor: Colors.grey,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        prefixIcon: Icon(icon),
        labelText: hintText,
        hintText: 'Enter',
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $hintText";
        }
        return null;
      },
    );
  }

  Widget _signupButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await Auth().createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign Up Successful!')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to sign up: ${e.toString()}')),
          );
        }
      },
      child: Text('Sign Up'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: MyColors().color9,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 110),
      ),
    );
  }

  Widget passwordField(String hintText, TextEditingController controller,
      IconData icon, bool isPassword) {
    bool _obscureText = isPassword;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return TextFormField(
          obscureText: _obscureText,
          controller: controller,
          cursorColor: Colors.grey,
          style: TextStyle(color: Colors.grey),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.3),
            prefixIcon: Icon(icon),
            hintText: 'Enter',
            hintStyle: TextStyle(color: Colors.grey),
            labelText: hintText,
            labelStyle: TextStyle(color: Colors.grey),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.black87.withOpacity(0.75),
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your password";
            }
            return null;
          },
        );
      },
    );
  }

  Future<void> signInWithGoogle() async {
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
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (context) => const HomePage()),
          //   (route) => false,
          // );
        }
      } else {
        print('aa: not worked');
      }
    } catch (e) {
      print('aa: Error: $e');
    }
  }

  Widget oauthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: signInWithGoogle,
            icon: Icon(
              FontAwesomeIcons.google,
              color: MyColors().color8,
              size: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: signInWithGoogle,
            icon: Icon(
              FontAwesomeIcons.microsoft,
              color: MyColors().color8,
              size: 35,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: signInWithGoogle,
            icon: Icon(
              FontAwesomeIcons.apple,
              color: MyColors().color8,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginText(WidgetRef ref) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black87.withOpacity(0.7),
          fontSize: 18,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Already have an account? ',
          ),
          TextSpan(
            text: 'Sign In\n',
            style: TextStyle(
              color: MyColors().color9,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                ref.read(showRegisterProvider.notifier).state =
                    !ref.read(showRegisterProvider.notifier).state;
              },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      key: ValueKey('registerPage'),
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black.withOpacity(0.8),
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/avatar6.png'),
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: nameField('Full Name', _nameController, Icons.person_outline),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: emailField('Email', _emailController, Icons.email_outlined),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: passwordField('Password', _passwordController,
              Icons.lock_outline_rounded, true),
        ),
        SizedBox(height: 30),
        _signupButton(context),
        SizedBox(height: 30),
        TextDivider.horizontal(
          text: const Text(
            'OR',
            style: TextStyle(),
          ),
          color: Colors.black87,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        SizedBox(height: 20),
        oauthRow(),
        SizedBox(height: 20),
        _loginText(ref),
      ],
    );
  }
}

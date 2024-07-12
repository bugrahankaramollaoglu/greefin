import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/pages/home_page.dart';
import 'package:greefin/pages/riverpod_providers.dart';
import 'package:greefin/utilities/my_colors.dart';

class LoginForm extends ConsumerWidget {
  LoginForm({super.key});

  String? errorMessage;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget emailField(
    String hintText,
    TextEditingController eController,
    IconData icon,
    bool isPassword,
  ) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      cursorColor: Colors.grey,
      controller: eController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        prefixIcon: Icon(icon),
        hintText: 'Enter',
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey), // Unfocused border color
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Focused border color
        ),
        labelText: hintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your password";
        }
        // Add your own password strength validation logic here (e.g., check for length and complexity)
        return null;
      },
    );
  }

  Widget passwordField(
    String hintText,
    TextEditingController pController,
    IconData icon,
    bool isPassword,
  ) {
    bool obscureText = isPassword;

    return TextFormField(
      obscureText: obscureText,
      controller: pController,
      cursorColor: Colors.grey,
      style: const TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        prefixIcon: Icon(icon),
        hintText: 'Enter',
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey), // Unfocused border color
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Focused border color
        ),
        labelText: hintText,
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.black87.withOpacity(0.75),
          ),
          onPressed: () {
            /*  setState(() {
              _obscureText = !_obscureText;
            }); */
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your password";
        }
        // Add your own password strength validation logic here (e.g., check for length and complexity)
        return null;
      },
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

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _signInWithEmailAndPassword(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: MyColors().color4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 110), // Adjust the horizontal padding
      ),
      child: const Text(
        'Login',
      ),
    );
  }

  Widget _guestButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.black87.withOpacity(0.6),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 110,
        ), // Adjust the horizontal padding
      ),
      child: const Text(
        'Guest',
      ),
    );
  }

  // Forgot Password Functionality
  Widget _forgotPassword(WidgetRef ref) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          ref.read(showForgotPasswdProvider.notifier).state =
              !ref.read(showForgotPasswdProvider.notifier).state;
        },
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: MyColors().color4,
            fontSize: 16,
            decoration: TextDecoration.underline,
            decorationColor: MyColors().color9,
          ),
        ),
      ),
    );
  }

  Widget _registerText(WidgetRef ref) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black87.withOpacity(0.7),
          fontSize: 18,
        ),
        children: <TextSpan>[
          const TextSpan(
            text: 'Don\'t have an account? ',
          ),
          TextSpan(
            text: 'Sign up',
            style: TextStyle(
              color: MyColors().color4, // Set your desired color her6
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigate to your sign-up screen or handle the tap event
                ref.read(showRegisterProvider.notifier).state =
                    !ref.read(showRegisterProvider.notifier).state;

                print('Sign up tapped');
              },
          ),
        ],
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Forgot Password?'),
          content: TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Enter your email',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Reset Password'),
              onPressed: () async {
                Navigator.pop(context); // Close the dialog
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                    email: emailController.text.trim(),
                  );

                  // Check if the context is still valid before showing SnackBar
                  if (ScaffoldMessenger.of(context).mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
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
                      const SnackBar(
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
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Widget oauthRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              signInWithGoogle(context);
            },
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
            onPressed: null,
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
            onPressed: null,
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

  Future<void> signInWithGoogle(BuildContext context) async {
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

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } on FirebaseAuthException {
      /*  setState(() {
        errorMessage = e.message;
      }); */
    }
  }

  Widget _logo() {
    return Image.asset('assets/greefin.png');
  }

  Widget _divider() {
    return SizedBox(
      width: 300,
      height: 75,
      child: Image.asset('assets/or.png'),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            30.0, 30.0, 30.0, MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            _logo(),
            const SizedBox(height: 20),
            emailField('Email', _emailController, Icons.email, false),
            const SizedBox(height: 20),
            passwordField('password', _passwordController, Icons.lock, true),
            _forgotPassword(ref), // Forgot password button
            const SizedBox(height: 20),
            _loginButton(context),
            _guestButton(),
            const SizedBox(height: 20),
            _divider(),
            oauthRow(context),
            const SizedBox(height: 20),
            _registerText(ref),
          ],
        ),
      ),
    );
  }
}

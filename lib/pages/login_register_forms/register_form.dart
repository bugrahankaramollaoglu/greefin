import 'package:auth_button_kit/auth_button_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greefin/pages/home_page.dart';
import 'package:greefin/utilities/my_colors.dart';
import 'package:text_divider/text_divider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget nameField(
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
        labelStyle:
            TextStyle(color: Colors.grey), // Style for the floating label
        floatingLabelBehavior:
            FloatingLabelBehavior.always, // Always show the floating label
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Unfocused border color
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Focused border color
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $hintText";
        }
        // Add your own validation logic here
        return null;
      },
    );
  }

  Widget _backToLoginButton() {
    return AuthButton(
      onPressed: (asd) {},
      // onPressed: (method) => setState(() => showLoginPage = true),
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
    String hintText,
    TextEditingController e_controller,
    IconData icon,
  ) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      cursorColor: Colors.grey,
      controller: _emailController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        prefixIcon: Icon(icon),
        labelText: hintText,
        hintText: 'Enter',
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle:
            TextStyle(color: Colors.grey), // Style for the floating label
        floatingLabelBehavior:
            FloatingLabelBehavior.always, // Always show the floating label
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Unfocused border color
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Focused border color
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $hintText";
        }
        // Add your own validation logic here
        return null;
      },
    );
  }

  Widget passwordField(
    String hintText,
    TextEditingController p_controller,
    IconData icon,
    bool isPassword,
  ) {
    bool _obscureText = isPassword;

    return TextFormField(
      obscureText: _obscureText,
      controller: p_controller,
      cursorColor: Colors.grey,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        prefixIcon: Icon(icon),
        hintText: 'Enter',
        hintStyle: TextStyle(color: Colors.grey),
        labelText: hintText,
        labelStyle:
            TextStyle(color: Colors.grey), // Style for the floating label
        floatingLabelBehavior:
            FloatingLabelBehavior.always, // Always show the floating label
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Unfocused border color
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
          borderSide: BorderSide(color: Colors.black), // Focused border color
          borderRadius: BorderRadius.circular(10.0),
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

  Widget _signupButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        'Sign Up',
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: MyColors().color9,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 110), // Adjust the horizontal padding
      ),
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

  Widget _loginText() {
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
              color: MyColors().color9, // Set your desired color her6
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigate to your sign-up screen or handle the tap event
                print('Sign up tapped');
              },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey('registerPage'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Sign Up', style: TextStyle(fontSize: 30)),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black
                  .withOpacity(0.8), // Choose your stroke color here
              width: 2, // Adjust the width of the border
            ),
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/avatar6.png'),
            // Add onTap to allow user to change profile picture
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
        _signupButton(),
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
        _loginText(),
      ],
    );
  }
}

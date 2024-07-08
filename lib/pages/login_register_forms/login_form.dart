import 'package:auth_button_kit/auth_button_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/pages/home_page.dart';
import 'package:greefin/utilities/my_colors.dart';

/* class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? errorMessage;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


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
} */

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

  Widget emailField(
    String hintText,
    TextEditingController e_controller,
    IconData icon,
    bool isPassword,
  ) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      cursorColor: Colors.grey,
      controller: e_controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        prefixIcon: Icon(icon),
        hintText: 'Enter',
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Unfocused border color
        ),
        focusedBorder: OutlineInputBorder(
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
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Unfocused border color
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Focused border color
        ),
        labelText: hintText,
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

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        'Login',
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 110), // Adjust the horizontal padding
      ),
    );
  }

  Widget _registerButton() {
    return AuthButton(
      onPressed: (asd) {},
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
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        'Guest',
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: Colors.black87.withOpacity(0.6),
            width: 1,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 110,
        ), // Adjust the horizontal padding
      ),
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
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => _showForgotPasswordDialog(context),
        // Use a method to show the dialog
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: MyColors().color9,
            fontSize: 16,
            decoration: TextDecoration.underline,
            decorationColor: MyColors().color9,
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black87.withOpacity(0.7),
          fontSize: 18,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Don\'t have an account? ',
          ),
          TextSpan(
            text: 'Sign up',
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
            onPressed: _signInWithGoogle,
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
            onPressed: _signInWithGoogle,
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

  Widget _divider() {
    return SizedBox(
      child: Image.asset('assets/or.png'),
      width: 300,
      height: 75,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey
                    .withOpacity(0.3), // Choose your stroke color here
                width: 6, // Adjust the width of the border
              ),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar6.png'),
              // Add onTap to allow user to change profile picture
            ),
          ),
          SizedBox(height: 20),
          emailField('Email', _emailController, Icons.email, false),
          SizedBox(height: 20),
          passwordField('password', _passwordController, Icons.lock, true),
          _forgotPassword(), // Forgot password button
          const SizedBox(height: 20),
          _loginButton(),
          _guestButton(),
          const SizedBox(height: 30),
          _divider(),
          SizedBox(height: 10),
          _oauthRow(),
          SizedBox(height: 20),
          _registerText(),
        ],
      ),
    );
  }
}

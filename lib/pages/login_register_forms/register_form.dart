import 'package:auth_button_kit/auth_button_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  Widget _backToLoginButton() {
    return AuthButton(
      onPressed: (asd){},
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

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('registerPage'),
      mainAxisSize: MainAxisSize.min,
      children: [
        /*  _entryField(
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
        errorMessageWidget(),
        const SizedBox(height: 20),
        _registerUserButton(),
        _backToLoginButton(),*/
      ],
    );
  }
}

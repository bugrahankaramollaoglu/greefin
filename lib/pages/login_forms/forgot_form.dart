import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greefin/pages/riverpod_providers.dart';
import 'package:greefin/utilities/my_colors.dart';

class ForgotPasswordForm extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordForm({super.key});

  Future<void> _sendPasswordResetEmail(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error! Please check your email address.'),
        ),
      );
    }
  }

  Widget _sendButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _sendPasswordResetEmail(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: MyColors().color4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 80),
      ),
      child: const Text('Send Reset Email'),
    );
  }

  Widget _goBackButton(WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref.read(showForgotPasswdProvider.notifier).state =
            !ref.read(showForgotPasswdProvider.notifier).state;
      },
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
        padding: const EdgeInsets.symmetric(horizontal: 80),
      ),
      child: const Text('        Go Back        '),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Type your email address',
          /*style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.grey.withOpacity(0.9),
          ),*/
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Email',
            ),
          ),
        ),
        const SizedBox(height: 30),
        _sendButton(context),
        const SizedBox(height: 10),
        _goBackButton(ref),
      ],
    );
  }
}

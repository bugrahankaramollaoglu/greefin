import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:greefin/pages/login_register_forms/register_form.dart';

import '../utilities/my_colors.dart';
import 'login_register_forms/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage;
  bool showLoginPage = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: GradientBorderContainer(showLoginPage: true),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final Color color;
  final double width;

  GradientBorderPainter({required this.color, required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [color, color.withOpacity(0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(20),
      ));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class GradientBorderContainer extends StatelessWidget {
  final bool showLoginPage;

  GradientBorderContainer({required this.showLoginPage});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientBorderPainter(
        color: MyColors().color9, // Set your desired color here
        width: 3,
      ),
      child: Container(
        width: 350,
        height: 700,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.grey.withOpacity(0.4), Colors.white],
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: showLoginPage ? LoginForm() : RegisterForm(),
      ),
    );
  }
}

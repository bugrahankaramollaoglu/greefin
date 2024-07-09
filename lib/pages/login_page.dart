import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greefin/main.dart';
import 'package:greefin/pages/login_register_forms/register_form.dart';
import 'package:greefin/pages/riverpod_providers.dart';
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
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: GradientBorderContainer(),
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
        colors: [color, color.withOpacity(1)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(20),
      ));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class GradientBorderContainer extends ConsumerWidget {
  const GradientBorderContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var isShowRegister = ref.watch(showRegisterProvider);

    return CustomPaint(
      painter: GradientBorderPainter(
        color: MyColors().color9,
        width: 2,
      ),
      child: Container(
        width: width * 0.9,
        height: height * 0.8,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [MyColors().color2.withOpacity(0.1), Colors.white],
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final fadeTransition =
                FadeTransition(opacity: animation, child: child);
            final scaleTransition = ScaleTransition(
              scale: Tween<double>(
                begin: 0.8,
                end: 1.0,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: fadeTransition,
            );
            return scaleTransition;
          },
          child: isShowRegister
              ? RegisterForm(key: ValueKey(1))
              : LoginForm(key: ValueKey(2)),
        ),
      ),
    );
  }
}

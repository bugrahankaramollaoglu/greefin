import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/background_final_button.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:greefin/pages/login_page.dart';

final Color kDarkBlueColor = const Color(0xFF053149);

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Register',
      onFinish: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: kDarkBlueColor,
      ),
      skipTextButton: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: kDarkBlueColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        'Login',
        style: TextStyle(
          fontSize: 16,
          color: kDarkBlueColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
      controllerColor: kDarkBlueColor,
      totalPage: 6,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Image.asset(
          'assets/slide_3.png',
          height: 400,
        ),
        Image.asset(
          'assets/slide_3.png',
          height: 400,
        ),
        Image.asset(
          'assets/slide_3.png',
          height: 400,
        ),
        Image.asset(
          'assets/slide_3.png',
          height: 400,
        ),
        Image.asset(
          'assets/slide_3.png',
          height: 400,
        ),
        Image.asset(
          'assets/slide_3.png',
          height: 400,
        ),
      ],
      speed: 1.8,
      pageBodies: [
        OnboardingPageTemplate(
          context,
          'Welcome to Greefin',
          'Greefin is a platform that helps you to manage your finances and investments.',
        ),
        OnboardingPageTemplate(
          context,
          'Investment',
          'Invest in the best companies and funds with just a few clicks.',
        ),
        OnboardingPageTemplate(
          context,
          'Savings',
          'Save money and earn interest on your savings.',
        ),
        OnboardingPageTemplate(
          context,
          'Budgeting',
          'Create a budget and track your expenses.',
        ),
        OnboardingPageTemplate(
          context,
          'Financial Goals',
          'Set financial goals and track your progress.',
        ),
        OnboardingPageTemplate(
          context,
          'Get Started',
          'Sign up to start managing your finances and investments.',
        ),
      ],
    );
  }
}

Widget OnboardingPageTemplate(
    BuildContext context, String title, String description) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          height: 480,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kDarkBlueColor,
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black26,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

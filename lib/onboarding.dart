import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:greefin/firebase/firebase_router.dart';
import 'package:greefin/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color kDarkBlueColor = Color(0xFFB6C8D2);

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => const FirebaseRouter(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Start',
      finishButtonTextStyle: const TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
      onFinish: () => _completeOnboarding(context),
      trailing: Container(
        color: const Color.fromARGB(255, 24, 24, 26),
      ),
      centerBackground: true,
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: Colors.lightGreenAccent,
        focusColor: Colors.black,
        splashColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      skipTextButton: const Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      controllerColor: kDarkBlueColor,
      totalPage: 6,
      headerBackgroundColor: const Color.fromARGB(255, 24, 24, 26),
      pageBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      background: [
        Image.asset(
          'assets/greefin.png',
          height: 400,
        ),
        Image.asset(
          'assets/greefin.png',
          height: 400,
        ),
        Image.asset(
          'assets/greefin.png',
          height: 400,
        ),
        Image.asset(
          'assets/greefin.png',
          height: 400,
        ),
        Image.asset(
          'assets/greefin.png',
          height: 400,
        ),
        Image.asset(
          'assets/greefin.png',
          height: 400,
        ),
      ],
      speed: 1.4,
      pageBodies: [
        OnboardingPageTemplate(
          context,
          'Welcome to ',
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
            style: const TextStyle(
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
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ));
}

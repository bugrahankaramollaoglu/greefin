// onboarding.dart
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greefin/shared_preferences.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'home_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    await setIsOpened(
        'isOpenedBefore', true); // Call the function from the utility file
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      skipStyle: ButtonStyle(
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 17)),
          foregroundColor: MaterialStateProperty.all(Colors.redAccent)),
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [
              Text('Your Personal Habit Manager',
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 248, 64, 64))),
              const SizedBox(height: 20),
              const Image(image: AssetImage('assets/dance.png')),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Image(image: AssetImage('assets/guitar.png')),
              const SizedBox(height: 20),
              Text('Play Guitar!',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 119, 56, 199)))
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Listen Music!',
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 33,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 248, 64, 64))),
              const SizedBox(height: 20),
              const Image(image: AssetImage('assets/listening.png')),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Image(image: AssetImage('assets/meditating.png')),
              const SizedBox(height: 20),
              Text('Keep Calm!',
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 33,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 119, 56, 199))),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Do Photography!',
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 33,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 248, 64, 64))),
              const SizedBox(height: 20),
              const Image(image: AssetImage('assets/photography.png')),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Image(image: AssetImage('assets/reading-book.png')),
              const SizedBox(height: 20),
              Text('Read Books!',
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 33,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 119, 56, 199))),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [
              Text("Do whatever you want!",
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 40, 183, 125))),
              const SizedBox(height: 30),
              Image(
                image: const AssetImage('assets/hobbies.png'),
                height: MediaQuery.of(context).size.height / 2,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              Text("We'll manage it for you",
                  style: GoogleFonts.mochiyPopOne(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 37, 119, 128))),
            ],
          ),
        ),
      ],
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(
        Icons.arrow_forward,
      ),
      done: const Text('Done',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 248, 64, 64))),
      onDone: () => _onIntroEnd(context),
      nextStyle: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 248, 64, 64))),
      dotsDecorator: const DotsDecorator(
        size: Size.square(10),
        activeColor: Colors.redAccent,
        activeSize: Size.square(17),
      ),
    );
  }
}

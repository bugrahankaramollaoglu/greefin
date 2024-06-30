import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/my_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MyColors _myColors = MyColors();

  @override
  Widget build(BuildContext context) {
    // build() metodu her rebuiltta tekrar çalışıyor

    final screen_h = MediaQuery.of(context).size.height;
    final screen_w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              Auth().signOut();
            },
            child: null)
      ],
    );
  }
}

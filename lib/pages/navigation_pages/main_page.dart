import 'package:flutter/material.dart';
import 'package:greefin/firebase/auth.dart';
import 'package:greefin/utilities/my_colors.dart';

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

    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
  
      ],
    );
  }
}

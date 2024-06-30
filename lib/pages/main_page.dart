import 'package:flutter/material.dart';
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

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screen_h / 3,
            color: _myColors.color1,
            child: Center(
              child: Text(
                'Main Page',
                style: TextStyle(
                  color: _myColors.color2,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('List Item ${index + 1}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

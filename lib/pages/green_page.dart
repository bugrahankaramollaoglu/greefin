import 'package:flutter/material.dart';

class GreenPage extends StatefulWidget {
  const GreenPage({super.key});

  @override
  State<GreenPage> createState() => _GreenPageState();
}

class _GreenPageState extends State<GreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Green Page',
              style: TextStyle(fontSize: 36),
            ),
          ],
        ),
      ),
    );
  }
}

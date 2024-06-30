import 'package:flutter/material.dart';

class GreenPage extends StatefulWidget {
  const GreenPage({super.key});

  @override
  State<GreenPage> createState() => _GreenPageState();
}

class _GreenPageState extends State<GreenPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}

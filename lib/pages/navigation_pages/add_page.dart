import 'package:flutter/material.dart';
import 'package:greefin/text_recognition/text_detector_view.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  void _openScanner() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 400,
            height: 400,
            child: TextRecognizerView(),
          )
        ],
      ),
    );
  }
}

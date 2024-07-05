import 'package:flutter/material.dart';
import 'package:greefin/text_detector_view.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  void _openScanner() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextRecognizerView(),
          SizedBox(height: 130),
          IconButton(
            onPressed: _openScanner,
            iconSize: 90,
            color: Colors.white,
            icon: Icon(Icons.qr_code_scanner_rounded),
          ),
        ],
      ),
    );
  }
}

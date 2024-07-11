import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';

class GreenPage extends StatelessWidget {
  const GreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/green_map');
              },
              child: Text('Map'),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/carbon_footprint');
              },
              child: Text('Carbon footprint'),
            ),
          ],
        ),
      ),
    );
  }
}

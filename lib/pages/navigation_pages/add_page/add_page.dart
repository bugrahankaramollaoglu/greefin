import 'package:flutter/material.dart';
import 'package:greefin/pages/navigation_pages/add_page/add_manually.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('open with qr'),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_manually');
              },
              child: const Text('open manually'),
            ),
          ],
        ),
      ),
    );
  }
}

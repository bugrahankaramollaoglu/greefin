import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Search Page'),
    Text('Profile Page'),
    Text('Profile Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Icon(
          icon,
          color: _selectedIndex == index ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomPaint(
        painter: BottomNavBarPainter(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          height: 80.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.search, 1),
              _buildNavItem(Icons.person, 2),
              _buildNavItem(Icons.person, 3),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 110, 166, 211)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, -50); // Start from the top left
    path.quadraticBezierTo(
        size.width * 0.1, 0, size.width * 0.2, 0); // Left curve
    path.lineTo(size.width * 0.8, 0); // Top line
    path.quadraticBezierTo(size.width * 0.9, 0, size.width, -50); // Right curve
    path.lineTo(size.width, size.height); // Right side
    path.lineTo(0, size.height); // Bottom line
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

/*
class BottomNavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromARGB(255, 110, 166, 211)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, -50); // Start from the top left
    path.quadraticBezierTo(
        size.width * 0.1, 0, size.width * 0.2, 0); // Left curve
    path.lineTo(size.width * 0.8, 0); // Top line
    path.quadraticBezierTo(size.width * 0.9, 0, size.width, -50); // Right curve
    path.lineTo(size.width, size.height); // Right side
    path.lineTo(0, size.height); // Bottom line
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
} */

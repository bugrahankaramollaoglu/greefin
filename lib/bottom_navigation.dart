import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onItemTapped(index);
      },
      child: Icon(
        icon,
        size: 30,
        color: widget.selectedIndex == index ? Colors.white : Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BottomNavBarPainter(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildNavItem(Icons.home, 0),
            _buildNavItem(Icons.search, 1),
            _buildNavItem(Icons.search, 2),
            _buildNavItem(Icons.person, 3),
          ],
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

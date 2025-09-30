import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Text('Contoh Dropdown Navbar')),
        bottomNavigationBar: CurvedNavBar(),
      ),
    );
  }
}

class CurvedNavBar extends StatefulWidget {
  const CurvedNavBar({super.key});

  @override
  State<CurvedNavBar> createState() => _CurvedNavBarState();
}

class _CurvedNavBarState extends State<CurvedNavBar> {
  bool showHomeMenu = false;
  bool showUserMenu = false;

  void toggleHomeMenu() {
    setState(() {
      showHomeMenu = !showHomeMenu;
      showUserMenu = false;
    });
  }

  void toggleUserMenu() {
    setState(() {
      showUserMenu = !showUserMenu;
      showHomeMenu = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(
            size: const Size(double.infinity, 107),
            painter: _NavBarPainter(),
          ),

          // Dropdown Home Menu
          if (showHomeMenu)
            Positioned(
              bottom: 70,
              left: 10,
              child: _buildDropdownMenu([
                "Dashboard",
                "News",
                "Profile",
              ]),
            ),

          // Dropdown User Menu
          if (showUserMenu)
            Positioned(
              bottom: 70,
              right: 10,
              child: _buildDropdownMenu([
                "Settings",
                "Logout",
              ]),
            ),

          // Icon buttons
          Positioned.fill(
            top: 140 / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: toggleHomeMenu,
                  icon: const Icon(Icons.home, color: Colors.white),
                ),
                const SizedBox(width: 56),
                IconButton(
                  onPressed: toggleUserMenu,
                  icon: const Icon(Icons.person, color: Colors.white),
                ),
              ],
            ),
          ),

          // Tombol tengah
          Positioned(
            left: MediaQuery.of(context).size.width * 0.5 - 28,
            top: 32,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF0BA89C), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.description, color: Color(0xFF0BA89C)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownMenu(List<String> items) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: items.map((text) {
            return InkWell(
              onTap: () {
                debugPrint("Kamu pilih $text");
                setState(() {
                  showHomeMenu = false;
                  showUserMenu = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(text, style: const TextStyle(fontSize: 14)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0BA89C)
      ..style = PaintingStyle.fill;

    final path = Path();

    final barHeight = size.height;
    final curveTop = 45.0;
    final radius = 16.0;
    final width = size.width;
    final centerX = width / 2;

    path.moveTo(0, barHeight);
    path.lineTo(0, curveTop + radius);
    path.arcToPoint(Offset(radius, curveTop),
        radius: Radius.circular(radius), clockwise: true);

    path.lineTo(centerX - 60, curveTop);
    path.cubicTo(centerX - 40, curveTop, centerX - 35, 20, centerX - 20, 10);
    path.cubicTo(centerX - 5, 0, centerX + 5, 0, centerX + 20, 10);
    path.cubicTo(centerX + 35, 20, centerX + 40, curveTop, centerX + 60, curveTop);
    path.lineTo(width - radius, curveTop);
    path.arcToPoint(Offset(width, curveTop + radius),
        radius: Radius.circular(radius), clockwise: true);
    path.lineTo(width, barHeight);
    path.close();

    canvas.drawShadow(path, Colors.black45, 10, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

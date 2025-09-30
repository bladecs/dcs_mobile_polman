import 'package:flutter/material.dart';
import 'widgets/curved_navbar.dart';
import 'pages/dashboard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // ✅ Gunakan List<Widget>
  final List<Widget> _pages = [
    const DashboardPage(),
    const Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          CurvedNavBar(),
        ],
      ),
    );
  }
}

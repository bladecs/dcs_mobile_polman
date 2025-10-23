import 'package:dcs_polman_kkn/widgets/bottom_nav_icon.dart';
import 'package:flutter/material.dart';
import 'package:dcs_polman_kkn/pages/document.dart';
import 'package:dcs_polman_kkn/pages/my_document.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopNavBar(),
            Expanded(
              child: Container(
                color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DaftarDocumentContent()
                      ],
                    ),
                  )
              )
            ),
            _buildBottomNavBar()
          ],
        )
      ),
    );
  }

  Widget _buildTopNavBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: Icon(
                Icons.search,
                color: Color(0xFF13A79B),
              ),
              trailing: <Widget>[
                Tooltip(
                  message: 'Notification',
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_active_outlined,
                        color: Color(0xFF13A79B),
                      )),
                ),
              ],
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List.generate(5, (int index) {
              final String item = 'Item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  controller.closeView(item);
                  controller.text = item;
                },
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: 75,
          decoration: BoxDecoration(
            color: Color(0xFF13A79B),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BottomNavBtn(
                icon: Icons.person_3_outlined,
                label: 'Users',
                currentIndex: _currentIndex,
                index: 1,
                onPressed: (val) {
                  setState(() {
                    _currentIndex = val;
                  });
                },
              ),
              BottomNavBtn(
                icon: Icons.dashboard_outlined,
                label: 'Home',
                currentIndex: _currentIndex,
                index: 0,
                onPressed: (val) {
                  setState(() {
                    _currentIndex = val;
                  });
                },
              ),
              BottomNavBtn(
                icon: Icons.note_add_outlined,
                label: 'Doc',
                currentIndex: _currentIndex,
                index: 2,
                onPressed: (val) {
                  setState(() {
                    _currentIndex = val;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

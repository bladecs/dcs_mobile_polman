import 'package:dcs_polman_kkn/pages/detail_document.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
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
  int _currentIndex = 0;
  String? _activePopupType;

  // Navigator key untuk masing-masing tab
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  List<Widget> _buildPages() {
    return [
      _buildNavigator(_navigatorKeys[0], const DaftarDocumentContent()),
      _buildNavigator(_navigatorKeys[1], const DocumentSayaContent()),
    ];
  }

  Widget _buildNavigator(GlobalKey<NavigatorState> key, Widget page) {
    return Navigator(
      key: key,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (_) => page,
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentIndex].currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildTopNavBar(),
              Expanded(
                  child: SingleChildScrollView(
                child: IndexedStack(
                  index: _currentIndex,
                  children: pages,
                ),
              )),
              _buildBottomNavBar()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopNavBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
        child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 4,
                    spreadRadius: 2,
                    color: Colors.black.withOpacity(0.1),
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_active_outlined,
                    color: Color(0xFF13A79B),
                  ),
                  Container(
                    width: 40,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 4,
                            spreadRadius: 2,
                            color: Colors.black.withOpacity(0.1),
                          )
                        ]),
                  )
                ],
              ),
            )),
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
                isPopupButton: true,
                popupType: 'user',
                activePopupType: _activePopupType,
                onPressed: (val) {
                  setState(() {
                    _currentIndex = val;
                    _activePopupType = 'user';
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
                    _activePopupType = null;
                  });
                },
              ),
              BottomNavBtn(
                icon: Icons.note_add_outlined,
                label: 'Doc',
                currentIndex: _currentIndex,
                isPopupButton: true,
                popupType: 'document',
                activePopupType: _activePopupType,
                onPressed: (val) {
                  setState(() {
                    _currentIndex = val;
                    _activePopupType = 'document';
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

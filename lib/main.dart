import 'package:anime_db/pages/browse.dart';
import 'package:anime_db/pages/history.dart';
import 'package:anime_db/pages/settings.dart';
import 'package:anime_db/styles/colorStyle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:anime_db/pages/home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsBinding.instance;
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  // (+) Handling Notifications
  @override
  void initState() {
    super.initState();

    // instance Firebase Messaging
    FirebaseMessaging.instance.getInitialMessage();

    // handling forground message
    FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
    });
    // handling background message
    FirebaseMessaging.onBackgroundMessage((message) async {
      if (message.notification != null) {
        print(message.notification!.title);
      }
    });
  }

  final pageOption = [
    HomePage(),
    BrowsePage(),
    HistoryPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageOption[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: blackPrimary,
        unselectedItemColor: navySoft,
        iconSize: 28,
        selectedLabelStyle:
            TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Browse"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

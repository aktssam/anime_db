import 'package:anime_db/bloc/anime_bloc.dart';
import 'package:anime_db/pages/browse.dart';
import 'package:anime_db/pages/history.dart';
import 'package:anime_db/pages/settings.dart';
import 'package:anime_db/styles/colorStyle.dart';
import 'package:anime_db/styles/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:anime_db/pages/home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsBinding.instance;
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: BottomNavBar(),
        );
      });
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
    // // instance Firebase Messaging
    // FirebaseMessaging.instance.getInitialMessage();
    // // handling forground message
    // FirebaseMessaging.onMessage.listen((message) async {
    //   print(message.notification?.title);
    //   print(message.notification?.body);
    // });
    // // handling background message
    // FirebaseMessaging.onBackgroundMessage((message) async {
    //   print(message);
    // });
  }

  final pageOption = [
    HomePage(),
    BlocProvider<AnimeBloc>(
        create: (_) => AnimeBloc()..add(AnimeEvent()), child: BrowsePage()),
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

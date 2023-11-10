import 'package:bottombar/screen/chat_page.dart';
import 'package:bottombar/screen/homepage.dart';
import 'package:bottombar/screen/profile_page.dart';
import 'package:bottombar/screen/setting_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color.fromARGB(255, 0, 38, 255)),
      home: main_Home(),
    );
  }
}

class main_Home extends StatefulWidget {
  const main_Home({super.key});

  @override
  State<main_Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<main_Home> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        animationDuration: Duration(seconds: 3),
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
    );
  }
}

List<Widget> pages = [
  const HomePage(),
  const ProfilePage(),
  const SettingPage(),
  const ChatPage()
];

import 'package:donation_app_igdtuw/screens/profileview.dart';
import 'package:flutter/material.dart';
import 'homepagemain.dart';
import 'home_screen.dart';

class navPage extends StatefulWidget {
  @override
  _navPageState createState() => _navPageState();
}

class _navPageState extends State<navPage>{
  int index = 0;
  final screens = [
    Home(),
    HomeScreen(),
    viewprofile(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: screens[index],
    bottomNavigationBar: NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.black,
      ),
      child: NavigationBar(
        height: 60,
        backgroundColor: Colors.white,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: index,
        animationDuration: Duration(seconds: 1),
        onDestinationSelected: (index) =>
            setState(() => this.index = index),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_outlined, color: Colors.orange.shade900.withOpacity(0.90)),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper_outlined),
            selectedIcon: Icon(Icons.newspaper_outlined, color: Colors.orange.shade900.withOpacity(0.90)),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_outline, color: Colors.orange.shade900.withOpacity(0.90)),
            label: '',
          ),
        ],
      ),
    ),
  );
}
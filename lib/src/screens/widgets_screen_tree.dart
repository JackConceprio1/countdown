import 'package:countdownplus/src/screens/landing_screen.dart';
import 'package:countdownplus/src/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class WidgetScreenTree extends StatefulWidget {
  const WidgetScreenTree({super.key});

  @override
  State<WidgetScreenTree> createState() => _WidgetScreenTreeState();
}

class _WidgetScreenTreeState extends State<WidgetScreenTree> {
  List<Widget> screens = [const LandingScreen(), const SettingsScreen()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: screens[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => {
          setState(() {
            currentIndex = value;
          }),
        },
        items: const [
          BottomNavigationBarItem(
            label: "Events",
            icon: Icon(Icons.class_rounded),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

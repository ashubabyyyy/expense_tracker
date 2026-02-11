import 'package:expense_trackker/views/history_screen.dart';
import 'package:expense_trackker/views/home_screen.dart';

import 'package:expense_trackker/views/stats_screen.dart';
import 'package:flutter/material.dart';

class Navigationscreen extends StatefulWidget {
  const Navigationscreen({super.key});

  @override
  State<Navigationscreen> createState() => _NavigationscreenState();
}

class _NavigationscreenState extends State<Navigationscreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [HomeScreen(), HistoryScreen(), StatsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: _currentIndex,

          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_sharp),
              label: "Stat",
            ),
          ],
        ),
      ),
    );
  }
}

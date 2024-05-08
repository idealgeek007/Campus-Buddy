import 'package:campus_buddy/screens/academics.dart';
import 'package:campus_buddy/screens/dashboard.dart';
import 'package:campus_buddy/screens/profle_page.dart';
import 'package:campus_buddy/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    DashBoardPage(),
    AcademicsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 5, 25, 10),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BottomNavigationBar(
              onTap: _navigationBottomBar,
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFFD8DCE5)
                  : Colors.black,
              unselectedItemColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Color(0xFF6D738A),
              iconSize: 32,
              backgroundColor: Theme.of(context).colorScheme.surface,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Bootstrap.house,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Bootstrap.mortarboard,
                  ),
                  label: 'Academics',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Bootstrap.grid,
                  ),
                  label: 'More',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

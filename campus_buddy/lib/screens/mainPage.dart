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
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _navigationBottomBar,
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
                Bootstrap.person,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Bootstrap.gear,
              ),
              label: 'Settings',
            ),
          ],
        ));
  }
}

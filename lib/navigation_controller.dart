import 'package:flutter/material.dart';
import 'home_page.dart';
import 'info_page.dart';
import 'profile_page.dart';

class NavigationController extends StatefulWidget {
  final int initialIndex;
  const NavigationController({super.key, this.initialIndex = 0});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  late int _selectedIndex;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pages = [
      const HomePage(),
      const InfoPage(),
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
} 
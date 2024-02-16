import 'package:flutter/material.dart';
import 'package:infoware/screens/form_screen.dart';
import 'package:infoware/screens/audio_screen.dart';
import 'package:infoware/screens/products_list_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ProductsListScreen(), // Replace Screen1 with your first screen widget
    FormScreen(), // Replace Screen2 with your second screen widget
    AudioScreen(), // Replace Screen2 with your second screen widget
    // Replace Screen3 with your third screen widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_indent_increase_outlined),
            label: 'Form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack_outlined),
            label: 'Audio',
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade700,
        onTap: _onItemTapped,
      ),
    );
  }
}

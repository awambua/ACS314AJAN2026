
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'cars.dart';
import 'orders.dart';
import 'profile.dart'; 

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Dashboard(),
    const Cars(),
    const Orders(),
    const ProfileScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color.fromARGB(255, 63, 3, 3),
        color: const Color.fromARGB(255, 63, 3, 3),
        animationDuration: const Duration(milliseconds: 300),
        index: _selectedIndex,
        items: const [
          Icon(Icons.dashboard, size: 30, color: Colors.white),
          Icon(Icons.directions_car, size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index as int;
          });
        },
      ),
    );
  }
  
  Widget? CurvedNavigationBar({required Color backgroundColor, required Color buttonBackgroundColor, required Color color, required Duration animationDuration, required int index, required List<Icon> items, required Null Function(index) onTap}) {
    return null;
  }
}

class index {
}
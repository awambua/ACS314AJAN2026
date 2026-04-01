import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/cars.dart';
import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/orders.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:flutter_application_1/views/signup.dart';

var myScreens = [Dashboard(), CarsPage(), Orders(), ProfileScreen()];
int selectedIndex = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.dashboard, size: 30),
          Icon(Icons.category, size: 30),
          Icon(Icons.line_style, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: myScreens[selectedIndex],
    );
  }
}

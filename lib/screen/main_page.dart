import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/components/recommend_university_carousel.dart';
import 'package:project2_mobile_app/components/favourite_university_list.dart';
import 'package:project2_mobile_app/screen/home_page.dart';
import 'package:project2_mobile_app/screen/landmark_discover_page.dart';
import 'package:project2_mobile_app/screen/profile_page.dart';

import '../components/favourite_university_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  static const List<Widget> _widgetOptions = <Widget>[HomePage(), LandMarkDiscoverPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),

        ),

        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apartment_outlined), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "")
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.yellow,
            unselectedItemColor: Colors.white,
            onTap: onTapped,
          ),
        ));
  }
}

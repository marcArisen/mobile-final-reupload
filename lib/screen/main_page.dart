import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/components/favourite_list.dart';
import 'package:project2_mobile_app/components/university_carousel.dart';
import 'package:project2_mobile_app/screen/home_page.dart';
import 'package:project2_mobile_app/screen/landmark_list_page.dart';
import 'package:project2_mobile_app/screen/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index){
    setState((){
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: pageController,
          children: const [
            HomePage(),
            LandmarkPage(),
            ProfilePage()
          ],
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
                  icon: Icon(Icons.home_outlined ), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apartment_outlined), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "")
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.yellow,
            unselectedItemColor: Colors.white,
            onTap: onTapped,
          ),
        ));
  }
}
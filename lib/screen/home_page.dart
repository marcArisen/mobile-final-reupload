import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project2_mobile_app/api/university_location_service.dart';
import 'package:project2_mobile_app/components/change_theme_button.dart';
import 'package:project2_mobile_app/components/favourite_list.dart';
import 'package:project2_mobile_app/components/university_carousel.dart';
import 'package:project2_mobile_app/components/university_google_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [ChangeThemeButtonWidget()],
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 0),
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 10),
                    child: Image.asset('assets/icons/profile.png'),
                  ),
                  Container(
                    width: 200,
                    child: Text("Welcome, Thanawat !",
                        style: GoogleFonts.lato(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              SizedBox(height: 14.0),
              Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Explore Thai Universities",
                    style: GoogleFonts.lato(
                        fontSize: 28.0, fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "We combine information you need to know about Thai universities.",
                  style: GoogleFonts.lato(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              UniversityCarousel(),
              FavouriteList()
            ],
          ),
        ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project2_mobile_app/api/nearby_landmarks_service.dart';
import 'package:project2_mobile_app/api/university_location_service.dart';
import 'package:project2_mobile_app/components/change_theme_button.dart';
import 'package:project2_mobile_app/components/nearby_university_carousel.dart';
import 'package:project2_mobile_app/components/recommend_university_carousel.dart';
import 'package:project2_mobile_app/components/university_google_map.dart';

import '../UniversityRepo/UniversityDatabase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseAuth _auth = FirebaseAuth.instance;
  late String loggedInUser = _auth.currentUser?.email ?? 'none';
  @override
  Widget build(BuildContext context) {
    // print(UniversityDatabase.databaseManager.convertToText(UniversityDatabase.universities[5].numbers!));
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
                  Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text("Welcome,",
                            style: GoogleFonts.lato(
                                fontSize: 24, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 200,
                          child: Text("${loggedInUser} !",
                              style: GoogleFonts.lato(
                                  fontSize: 18, fontWeight: FontWeight.w300)))
                    ],
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
              NearbyUniversityCarousel(),
              UniversityCarousel()
            ],
          ),
        ));
  }
}

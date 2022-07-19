import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/UniversityRepo/university.dart';
import 'package:project2_mobile_app/screen/favourite_university_page.dart';

import '../api/nearby_landmarks_service.dart';
import '../api/university_location_service.dart';
import '../screen/university_page.dart';

/// Favourites Universities list
class FavouriteList extends StatelessWidget {
  const FavouriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("My Selected University",
                    style: GoogleFonts.lato(
                        fontSize: 20.0, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavouriteUniversityPage())),
                  child: Text(
                    "See All",
                    style: GoogleFonts.lato(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }


}

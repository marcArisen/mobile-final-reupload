import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/components/favourite_list.dart';
import 'package:project2_mobile_app/components/university_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDDF9F7),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 10),
                  child: Image.asset('assets/icons/profile.png'),
                ),
                 Text("Thanawat",
                    style: GoogleFonts.lato(fontSize: 28, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(height: 10.0)
            ,
             Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Explore Thai Universities",
                  style: GoogleFonts.lato(fontSize: 28.0, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20.0),
              child: Text(
                "We combine information you need to know about Thai universities.",
                style: GoogleFonts.lato(fontSize: 16.0, ),
              ),
            ),
            SizedBox(height: 20.0),
            UniversityCarousel(),
            FavouriteList()
          ],
        ),
      ),
    );
  }
}
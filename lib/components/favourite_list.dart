import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/model/university_model.dart';
import 'package:project2_mobile_app/screen/favourite_university_page.dart';

/// Favourites Universities list
class FavouriteList extends StatelessWidget {
  const FavouriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
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
        Container(
          height: 210,
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                University university = universities[index];
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 5.0, top: 10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundImage: AssetImage(university.logo)),
                    title: Text(
                      university.name,
                      style: GoogleFonts.lato(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}

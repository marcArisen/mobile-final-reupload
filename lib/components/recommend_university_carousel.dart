import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/model/landmark_model.dart';

// import 'package:project2_mobile_app/model/university_model.dart';
import 'package:project2_mobile_app/screen/university_list_page.dart';
import 'package:project2_mobile_app/screen/university_page.dart';

import '../UniversityRepo/UniversityDatabase.dart';
import '../UniversityRepo/university.dart';
import '../api/university_location_service.dart';

/// Carousel to display recommended universities
class UniversityCarousel extends StatefulWidget {
  const UniversityCarousel({Key? key}) : super(key: key);

  @override
  State<UniversityCarousel> createState() => _UniversityCarouselState();
}

class _UniversityCarouselState extends State<UniversityCarousel> {
  @override
  Widget build(BuildContext context) {
    var universities = UniversityDatabase.universities;
    // UniversityDatabase.databaseManager.getAllUniversities();
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Text("Recommend",
                      style: GoogleFonts.lato(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(width: 5.0),
                  Icon(Icons.thumb_up)
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UniversityListPage())),
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
          height: 300.0,
          //color: Colors.blue,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              University university = universities[index];
              return GestureDetector(
                onTap: () async {
                  String placeId =
                      await LocationService().getPlaceId(university.thaiName!);
                  Map<String, dynamic> m =
                      await LocationService().getPlace(university.name!);
                  double rating = await LocationService().getRating(university.thaiName!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UniversityPage(
                                location: m,
                                university: university,
                                placeId: placeId,
                                rating: rating
                              )));
                },
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  width: 210.0,
                  //color: Colors.red,
                  child:
                      Stack(alignment: Alignment.topCenter, children: <Widget>[
                    Positioned(
                      bottom: 15.0,
                      child: Container(
                        height: 100.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Align(
                                          child: Text(
                                            "Foreign students enrolled in 2021",
                                            style: GoogleFonts.lato(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(UniversityDatabase.databaseManager.convertToText(university.numbers.toString()))
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              height: 180.0,
                              width: 180.0,
                              image: AssetImage(university.imageUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 10.0,
                            bottom: 10.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  university.name!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

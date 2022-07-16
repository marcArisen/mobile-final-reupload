import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/screen/university_list_page.dart';
import 'package:project2_mobile_app/screen/university_page.dart';
import '../UniversityRepo/UniversityDatabase.dart';
import '../UniversityRepo/university.dart';
import '../api/university_location_service.dart';

/// Carousel to display recommended universities
class NearbyUniversityCarousel extends StatefulWidget {
  const NearbyUniversityCarousel({Key? key}) : super(key: key);

  @override
  State<NearbyUniversityCarousel> createState() => _NearbyUniversityCarouselState();
}

class _NearbyUniversityCarouselState extends State<NearbyUniversityCarousel> {
  //var locationMessage = '';
  String? latitude;
  String? longitude;


  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";
    print(latitude);
    print(longitude);
  }

  @override
  Widget build(BuildContext context) {
    var universities = UniversityDatabase.universities;
    // getCurrentLocation();

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Nearby",
                  style: GoogleFonts.lato(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),
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
            itemCount: universities.length,
            itemBuilder: (BuildContext context, int index) {
              University university = universities[index];
              return GestureDetector(
                onTap: () async {
                  Map<String, dynamic> m =
                      await LocationService().getPlace(university.name!);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UniversityPage(
                                location: m, university: university)));
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Foreign students enrolled in 2021",
                                      style: GoogleFonts.lato(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: university.country.map((rating) {
                                //     return SizedBox(
                                //       width: 30,
                                //       child: Text(
                                //         rating,
                                //         style: GoogleFonts.lato(fontSize: 13.0),
                                //       ),
                                //     );
                                //   }).toList(),
                                // ),
                                // SizedBox(height: 5),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: university.flag.map((flag) {
                                //     return SizedBox(
                                //       width: 30,
                                //       child: Text(
                                //         flag,
                                //         style: GoogleFonts.lato(fontSize: 13.0),
                                //       ),
                                //     );
                                //   }).toList(),
                                // ),
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
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.locationArrow,
                                      size: 10.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      "Salaya",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ],
                                ),
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

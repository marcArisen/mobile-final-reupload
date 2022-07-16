import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/api/nearby_landmarks_service.dart';
import 'package:project2_mobile_app/screen/university_list_page.dart';
import 'package:project2_mobile_app/screen/university_page.dart';
import '../UniversityRepo/UniversityDatabase.dart';
import '../UniversityRepo/university.dart';
import '../api/university_location_service.dart';
import '../model/landmark_model.dart';

/// Carousel to display recommended universities
class NearbyUniversityCarousel extends StatefulWidget {
  const NearbyUniversityCarousel({Key? key}) : super(key: key);

  @override
  State<NearbyUniversityCarousel> createState() => _NearbyUniversityCarouselState();
}

class _NearbyUniversityCarouselState extends State<NearbyUniversityCarousel> {


  @override
  Widget build(BuildContext context) {
    /// Building nearby university carousel
    var futureNearbyUniBuilder = FutureBuilder(
      future: NearbyLocationService.instance
          ?.getNearbyUni(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return createNearbyCarousel(context, snapshot);
            }
        }
      },
    );
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
          child: futureNearbyUniBuilder
        )
      ],
    );
  }

  Widget createNearbyCarousel(BuildContext context, AsyncSnapshot snapshot){
    List<Landmark> nearbyUni = snapshot.data;
    /*
    for(Landmark uni in nearbyUni){
      print(uni.name);
    }

     */


    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: nearbyUni.length,
      itemBuilder: (BuildContext context, int index) {
        Landmark university = nearbyUni[index];
        return GestureDetector(
          onTap: (){
            print("hi");
        } /*async {
            Map<String, dynamic> m =
            await LocationService().getPlace(university.name!);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UniversityPage(
                        location: m, university: university)));
                        */

          ,
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
                      child: Container(
                        height: 180.0,
                        width: 180.0,
                        child: NearbyLocationService.instance?.getImage(university.photos![0].photoReference.toString()),

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
    );
  }
}

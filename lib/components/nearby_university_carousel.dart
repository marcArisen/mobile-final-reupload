import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/api/nearby_landmarks_service.dart';
import 'package:project2_mobile_app/screen/nearby_univeristy_page.dart';
import '../api/university_location_service.dart';
import '../model/landmark_model.dart';
import '../screen/landmark_page.dart';

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
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Nearby",
                  style: GoogleFonts.lato(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(width: 5.0),
              Icon(Icons.location_on)

            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          height: 220.0,
          //color: Colors.blue,
          child: futureNearbyUniBuilder
        )
      ],
    );
  }

  Widget createNearbyCarousel(BuildContext context, AsyncSnapshot snapshot){
    List<Landmark> nearbyUni = snapshot.data;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: nearbyUni.length,
      itemBuilder: (BuildContext context, int index) {
        Landmark university = nearbyUni[index];
        return GestureDetector(
          onTap: ()
          async {
            Map<String, dynamic> m =
            await LocationService().getPlace(university.name!);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NearbyUniversityPage(
                      landMark: university,)));
        }
          ,
          child: Container(
            margin: EdgeInsets.all(10.0),
            //color: Colors.red,
            child:
            Stack(alignment: Alignment.topCenter, children: <Widget>[

              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: SizedBox(
                        height: 180.0,
                        width: 250.0,
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: NearbyLocationService.instance?.getImage(university.photos![0].photoReference.toString())),

                      ),

                    ),
                    Positioned(
                      left: 10.0,
                      bottom: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 200.0,
                            child: Text(
                              university.name!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Row(
                              children: [
                                RatingBarIndicator(
                                  itemSize: 20,
                                  rating: university.rating!.toDouble(),
                                  itemCount: 5,
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: Colors.yellow),
                                ),
                                Text(
                                  "(${university.rating.toString()})",
                                  style: TextStyle(color: Colors.white),
                                )
                              ]
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

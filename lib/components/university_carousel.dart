import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/model/university_model.dart';

class UniversityCarousel extends StatelessWidget {
  const UniversityCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Recommend",
                  style: GoogleFonts.lato(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () => print("pressed"),
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
              return Container(
                margin: EdgeInsets.all(10.0),
                width: 210.0,
                //color: Colors.red,
                child: Stack(alignment: Alignment.topCenter, children: <Widget>[
                  Positioned(
                    bottom: 15.0,
                    child: Container(
                      height: 120.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${university.name}',
                            style: GoogleFonts.lato(
                                fontSize: 14.0, fontWeight: FontWeight.w600),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: university.country.map((rating) {
                              return Container(
                                width: 40,
                                child: Text(rating, style: GoogleFonts.lato(fontSize: 12.0),),
                              );
                            }).toList(),
                          ),
                          /*
                          Text(
                            '${university.country.toString()}', style: GoogleFonts.notoSans(
                            fontSize: 12.0, fontWeight: FontWeight.w600
                          ),
                          )
                           */
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0)
                        ]),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image(
                            height: 180.0,
                            width: 180.0,
                            image: AssetImage(university.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              );
            },
          ),
        )
      ],
    );
  }
}
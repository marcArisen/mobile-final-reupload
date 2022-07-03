import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/model/university_model.dart';

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
                  style:
                  GoogleFonts.notoSans(fontSize: 20.0, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () => print("pressed"),
                child: Text(
                  "See All",
                  style: GoogleFonts.notoSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: universities.length,
            itemBuilder: (BuildContext context, int index){
              University university = universities[index];
              return Card(
                margin: EdgeInsets.only(left:15.0, right: 15.0, bottom: 5.0,top: 10.0),
                child: ListTile(title: Text(university.name, style: GoogleFonts.notoSans(fontSize: 16.0, fontWeight: FontWeight.w600),),
                ),
              );

          }

          ),
        )



      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/university_model.dart';

class FavouriteUniversityPage extends StatefulWidget {
  const FavouriteUniversityPage({Key? key}) : super(key: key);

  @override
  State<FavouriteUniversityPage> createState() => _FavouriteUniversityPageState();
}

class _FavouriteUniversityPageState extends State<FavouriteUniversityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Theme.of(context).canvasColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: universities.length,
              itemBuilder: (BuildContext context, int index){
                University university = universities[index];
                return Card(
                  margin: EdgeInsets.only(left:15.0, right: 15.0, bottom: 5.0,top: 10.0),
                  child: ListTile(title: Text(university.name, style: GoogleFonts.lato(fontSize: 16.0, ),textAlign: TextAlign.center,),
                ));
              },
            )
          )
        ],
      ),
    );
  }
}

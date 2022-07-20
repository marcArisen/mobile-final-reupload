import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/UniversityRepo/UniversityDatabase.dart';
import 'package:project2_mobile_app/api/university_location_service.dart';
import 'package:project2_mobile_app/components/university_google_map.dart';
import 'package:project2_mobile_app/provider/theme_provider.dart';

import '../UniversityRepo/university.dart';
import '../api/nearby_landmarks_service.dart';

class UniversityPage extends StatefulWidget {
  final University university;
  final Map<String, dynamic> location;
  final String placeId;
  final double rating;

  UniversityPage(
      {required this.university,
      required this.location,
      required this.placeId,
      required this.rating});

  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  late final FirebaseAuth _auth = FirebaseAuth.instance;
  late final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String loggedInUser = _auth.currentUser?.email ?? 'none';
  var _isFavorite;

  Future<bool> checkFav(String user, int id) async {
    var jsonString = UniversityDatabase.universities[2].numbers;
    final decodedMap = json.decode(jsonString!);
    final list = await _firestore.collection(user).get();
    var to_return = [];
    for (var ele in list.docs) {
      int id = ele.get('id');
      to_return.add(id);
    }
    to_return = to_return.toSet().toList();
    for (var i = 0; i < to_return.length; i++) {
      if (to_return[i] == id) {
        return true;
      }
    }
    return false;
  }

  /// determine if it needs to be added to firebase

  void addUniversityToFirebase(String user, University university) {
    FirebaseFirestore.instance
        .collection(user)
        .doc(university.name)
        .set(university.toJson());
  }

  void deleteUniversityToFirebase(String user, University university) {
    FirebaseFirestore.instance
        .collection(user)
        .doc(university.name) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .then((_) => print(' ${university.name} Deleted'))
        .catchError(
            (error) => print("this university  doesn't save to favorite"));
  }

  @override
  Widget build(BuildContext context) {
    var futureUniversityInfoBuilder = FutureBuilder(
      future: NearbyLocationService.instance?.getInfo(widget.placeId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return createInformationWidget(context, snapshot);
            }
        }
      },
    );
    var universityReview = FutureBuilder(
      future: NearbyLocationService.instance?.getInfo(widget.placeId),
      //NearbyLocationService.instance
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return createReviewListView(context, snapshot);
            }
        }
      },
    );

    var favoriteHeart = FutureBuilder(
      future: checkFav(loggedInUser, widget.university.id!),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              bool info = snapshot.data as bool;
              _isFavorite = info;
              return FavoriteButton(
                isFavorite: _isFavorite,
                valueChanged: (snapshot) {
                  print('Is Favorite : $snapshot');
                  if (snapshot == true) {
                    addUniversityToFirebase(loggedInUser, widget.university);
                  } else {
                    deleteUniversityToFirebase(loggedInUser, widget.university);
                  }
                },
              );
            }
        }
      },
    );

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          )
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image(
                        image: AssetImage(widget.university.imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.arrow_back),
                            iconSize: 30.0,
                            onPressed: () => {
                                  Navigator.pop(context),
                                }),
                        favoriteHeart,
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20.0,
                    bottom: 20.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.university.name!,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: widget.rating!.toDouble(),
                              itemCount: 5,
                              itemBuilder: (context, _) =>
                                  Icon(Icons.star, color: Colors.yellow),
                            ),
                            Text(
                              "(${widget.rating.toString()})",
                              style: GoogleFonts.lato(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                width: 380,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text("Info",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ),
                    SizedBox(height: 10.0),
                    futureUniversityInfoBuilder,
                    SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.center,
                      child: Text("Number of foreigners enrolled in 2020",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500, fontSize: 16.0)),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                        height: 60.0,
                        width: 370.0,
                        child: Align(
                            child: Text(
                          UniversityDatabase.databaseManager.convertToText(
                              widget.university.numbers.toString()),
                          style: GoogleFonts.lato(fontSize: 16.0),
                        )),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).canvasColor)),
                    SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.center,
                      child: Text("Location",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ),
                    SizedBox(height: 10.0),
                    LocationMap(place: widget.location),
                    SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.center,
                      child: Text("Reviews",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ),
                    SizedBox(height: 10.0),
                    universityReview
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Create a review list for each landmarks
  Widget createReviewListView(BuildContext context, AsyncSnapshot snapshot) {
    Map<String, dynamic> info = snapshot.data;
    List<dynamic> reviews = [];
    if (info.containsKey("reviews")) {
      reviews = info["reviews"];
    } else {
      reviews.add({"author_name": "", "text": "No Comments"});
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      itemCount: reviews.length,
      itemBuilder: (BuildContext, int index) {
        return Card(
            elevation: 0,
            child: ListTile(
              title: Text(reviews[index]["author_name"]),
              subtitle: Text(reviews[index]["text"]),
            ));
      },
    );
  }

  /// Create information widget for each landmarks
  Widget createInformationWidget(BuildContext context, AsyncSnapshot snapshot) {
    Map<String, dynamic> info = snapshot.data;
    return Container(
        height: 60.0,
        width: 370.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).canvasColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 10.0),
                Text(info["formatted_phone_number"])
              ],
            ),
            SizedBox(width: 30.0),
            Row(
              children: [
                Icon(CupertinoIcons.globe),
                SizedBox(width: 10.0),
                Text(info["website"])
              ],
            ),
          ],
        ));
  }
}

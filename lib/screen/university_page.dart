import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project2_mobile_app/UniversityRepo/UniversityDatabase.dart';
import 'package:project2_mobile_app/components/university_google_map.dart';

import '../UniversityRepo/university.dart';
import '../api/nearby_landmarks_service.dart';

class UniversityPage extends StatefulWidget {
  final University university;
  final Map<String, dynamic> location;
  final String placeId;

  UniversityPage({required this.university, required this.location,required this.placeId});

  @override
  State<UniversityPage> createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  late final FirebaseAuth _auth = FirebaseAuth.instance;
  late final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String loggedInUser = _auth.currentUser?.email ?? 'none';
  var _isFavorite;

  Future<bool> checkFav(String user, int id) async {
    final list = await _firestore.collection(user).get();
    var to_return = [];
    for (var ele in list.docs) {
      int id = ele.get('id');
      to_return.add(id);
    }
    to_return = to_return.toSet().toList();
    for (var i = 0; i < to_return.length; i++){
      if (to_return[i] == id){
        return true;
      }
    }
    return false;
  }

  /// determine if it needs to be added to firebase
  void endFirebaseProcess(String user, University university, bool isFav) {
    print("Status now is: " + isFav.toString());
    if (isFav == false){
      addUniversityToFirebase(user, university);
    } else{
      deleteUniversityToFirebase(user, university);
    }
  }

  void addUniversityToFirebase(String user, University university){
    FirebaseFirestore.instance.collection(user).doc(university.name).set(university.toJson());
  }

  void deleteUniversityToFirebase(String user, University university){
    FirebaseFirestore.instance.collection(user)
        .doc(university.name) // <-- Doc ID to be deleted.
        .delete() // <-- Delete
        .then((_) => print(' ${university.name} Deleted'))
        .catchError((error) => print("this university  doesn't save to favorite"));
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
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: 30.0,
                          onPressed: () => {
                            endFirebaseProcess(loggedInUser, widget.university, _isFavorite),
                            Navigator.pop(context),
                          }
                        ),
                        // FavoriteButton(
                        //   isFavorite: _isFavorite,
                        //   valueChanged: (_isFavorite) {
                        //     print('Is Favorite : $_isFavorite');
                        //   },
                        // ),
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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.locationArrow,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              "Salaya",
                              style: TextStyle(color: Colors.white, fontSize: 18.0),
                            ),
                          ],
                        ),
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
                      alignment: Alignment.topLeft,
                      child: Text(" Info",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                    ),
                    SizedBox(height: 10.0),
                    futureUniversityInfoBuilder,
                    SizedBox(height: 10.0),
                    Container(
                        height: 60.0,
                        width: 370.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).canvasColor)
                    ),
                    SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(" Location",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                    ),
                    SizedBox(height: 10.0),
                    LocationMap(place: widget.location),
                  ],
                ),
              )


            ],
          ),
        ),
      ),
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

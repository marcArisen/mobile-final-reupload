import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/UniversityRepo/UniversityDatabase.dart';
import 'package:project2_mobile_app/screen/university_page.dart';
import '../UniversityRepo/university.dart';
import '../api/university_location_service.dart';

class FavouriteUniversityPage extends StatefulWidget {
  const FavouriteUniversityPage({Key? key}) : super(key: key);

  @override
  State<FavouriteUniversityPage> createState() =>
      _FavouriteUniversityPageState();
}

class _FavouriteUniversityPageState extends State<FavouriteUniversityPage> {
  late final FirebaseAuth _auth = FirebaseAuth.instance;
  late final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String loggedInUser = _auth.currentUser?.email ?? 'none';

  Future<List<University>> filterUniversities(String user) async {
    final list = await _firestore.collection(user).get();
    var toReturn = [];
    for (var ele in list.docs) {
      int id = ele.get('id');
      toReturn.add(id);
    }
    toReturn = toReturn.toSet().toList();

    List<University> favUniversities = [];
    List<University> uniList = UniversityDatabase.universities;
    for (var i = 0; i < toReturn.length; i++) {
      favUniversities.add(uniList[toReturn[i] - 1]);
    }
    return favUniversities;
  }

  @override
  Widget build(BuildContext context) {
    ///Restaurant ListView
    var futureRestaurantBuilder = FutureBuilder(
      future: filterUniversities(loggedInUser),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return createFavouriteListView(context, snapshot);
            }
        }
      },
    );

    return futureRestaurantBuilder;
  }

  /// Create FavouriteListView for displaying Favourite University
  Widget createFavouriteListView(BuildContext context, AsyncSnapshot snapshot) {
    List<University> favouriteUniversity = snapshot.data;
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () async {
              String placeId = await LocationService()
                  .getPlaceId(favouriteUniversity[index].thaiName!);
              Map<String, dynamic> m = await LocationService()
                  .getPlace(favouriteUniversity[index].name!);
              double rating = await LocationService().getRating(favouriteUniversity[index].thaiName!);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UniversityPage(
                            rating: rating,
                            location: m,
                            university: favouriteUniversity[index],
                            placeId: placeId,
                          )));
            },
            child: Card(
              margin: EdgeInsets.only(
                  left: 15.0, right: 15.0, bottom: 5.0, top: 10.0),
              child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage(favouriteUniversity[index].logo.toString()),
                  ),
                  title: Text(
                    favouriteUniversity[index].name.toString(),
                    style: GoogleFonts.lato(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ));
      },
    );
  }
}

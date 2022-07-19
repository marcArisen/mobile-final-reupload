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
  State<FavouriteUniversityPage> createState() => _FavouriteUniversityPageState();
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
    for (var i = 0; i < toReturn.length; i++){
      favUniversities.add(uniList[toReturn[i] - 1 ]);
      print(favUniversities[i]);
    }
    return favUniversities ;
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
            height: 500.0,
              child: futureRestaurantBuilder)
        ],
      ),
    );
  }


  /// Create FavouriteListView for displaying Favourite University
  Widget createFavouriteListView(BuildContext context, AsyncSnapshot snapshot) {
    List<University> favouriteUniversity = snapshot.data;
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.only(left:15.0, right: 15.0, bottom: 5.0,top: 10.0),
          child: ListTile(title: Text(favouriteUniversity[index].name.toString(), style: GoogleFonts.lato(fontSize: 16.0, ),textAlign: TextAlign.center,),
        /*
        return GestureDetector(
            onTap: () async {
              String placeId =
              await LocationService().getPlaceId(snapshot.data[index].thaiName!);
              Map<String, dynamic> m =
              await LocationService().getPlace(snapshot.data[index].name!);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UniversityPage(
                        location: m,
                        university: snapshot.data[index],
                        placeId: placeId,
                      )));
            },
          child: Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: SizedBox(
                    height: 250,
                    width: 400,
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(snapshot.data[index].imageUrl.toString()),
                    ),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 300.0,
                        child: Text(
                          snapshot.data[index].name.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: favouriteUniveristy[index].rating!.toDouble(),
                            itemCount: 5,
                            itemBuilder: (context, _) =>
                                Icon(Icons.star, color: Colors.yellow),
                          ),
                          Text(
                            "(${favouriteUniveristy[index].rating.toString()})",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )


                    ],
                  ),
                )
              ],
            ),

         */
          ),
        );
      },
    );
  }


}

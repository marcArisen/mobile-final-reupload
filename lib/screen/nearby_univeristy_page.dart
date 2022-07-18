import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project2_mobile_app/components/landmark_google_map.dart';
import 'package:project2_mobile_app/model/landmark_model.dart';
import '../api/nearby_landmarks_service.dart';
import '../components/university_google_map.dart';

class NearbyUniversityPage extends StatefulWidget {
  final Landmark landMark;

  NearbyUniversityPage({required this.landMark});

  @override
  State<NearbyUniversityPage> createState() => _NearbyUniversityPageState();
}

class _NearbyUniversityPageState extends State<NearbyUniversityPage> {
  @override
  Widget build(BuildContext context) {
    var futureLandMarkReviewBuilder = FutureBuilder(
      future: NearbyLocationService.instance
          ?.getInfo(widget.landMark.placeId.toString()),
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
    var futureLandMarkInfoBuilder = FutureBuilder(
      future: NearbyLocationService.instance
          ?.getInfo(widget.landMark.placeId.toString()),
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

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Landmark profile picture
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
                      child: NearbyLocationService.instance?.getImage(
                          widget.landMark.photos![0].photoReference.toString()),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: 30.0,
                          onPressed: () => Navigator.pop(context),
                        )
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
                          widget.landMark.name.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 5.0),
                            RatingBarIndicator(
                              rating: widget.landMark.rating!.toDouble(),
                              itemCount: 5,
                              itemBuilder: (context, _) =>
                                  Icon(Icons.star, color: Colors.yellow),
                            ),
                            Text(
                                "(${widget.landMark.rating!.toDouble().toString()})",style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),

              /// Information Section
              Container(
                width: 380,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("  Info",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                    ),
                    SizedBox(height: 10.0),
                    futureLandMarkInfoBuilder,
                    SizedBox(height: 10.0),
                    /// Google section
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("  Location",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                    ),
                    SizedBox(height: 10.0),
                    LandmarkLocationMap(
                        lat: widget.landMark.geometry?.location!.lat,
                        lng: widget.landMark.geometry?.location!.lng),
                    SizedBox(height: 10.0),
                    /// Reviews section
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("  Reviews",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                    ),
                    SizedBox(height: 10.0),
                    futureLandMarkReviewBuilder
                  ],
                ),
              ),
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
                Container(
                    width: 170,
                    child: Text(info["website"]))
              ],
            ),
          ],
        ));
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
}

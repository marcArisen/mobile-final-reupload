import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project2_mobile_app/components/landmark_google_map.dart';
import 'package:project2_mobile_app/model/landmark_model.dart';
import '../api/nearby_landmarks_service.dart';
import '../components/university_google_map.dart';

class LandmarkPage extends StatefulWidget {
  final Landmark landMark;

  LandmarkPage({required this.landMark});

  @override
  State<LandmarkPage> createState() => _LandmarkPageState();
}

class _LandmarkPageState extends State<LandmarkPage> {
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
                          color: Colors.white,
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
                        Container(
                          width: 300.0,
                          child: Text(
                            widget.landMark.name.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
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
                                "(${widget.landMark.rating!.toDouble().toString()})")
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// Information Section
              Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Info",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0)),
                  ),
                  SizedBox(height: 10.0),
                  futureLandMarkInfoBuilder,
                  SizedBox(height: 10.0),
                  /// Google section
                  Text(" Location",
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0)),
                  SizedBox(height: 10.0),
                  LandmarkLocationMap(
                      lat: widget.landMark.geometry?.location!.lat,
                      lng: widget.landMark.geometry?.location!.lng),
                  SizedBox(height: 10.0),
                  /// Reviews section
                  Text(" Reviews",
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0)),
                  futureLandMarkReviewBuilder
                ],
              ),
              //SizedBox(height: 20.0)//MapSample(place: widget.location)
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
                Icon(Icons.access_time_filled),
                SizedBox(width: 10.0),
                Text((() {
                  if (info["opening_hours"]["open_now"].toString() == "true") {
                    return "Currently Open";
                  }
                  return "Currently Closed";
                })())
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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project2_mobile_app/model/landmark_model.dart';
import '../api/nearby_landmarks_service.dart';

class LandmarkPage extends StatefulWidget {
  final Landmark landMark;
  LandmarkPage({required this.landMark});

  @override
  State<LandmarkPage> createState() => _LandmarkPageState();
}

class _LandmarkPageState extends State<LandmarkPage> {

  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder(
      future: NearbyLocationService.instance?.getInfo(widget.landMark.placeId.toString()),
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
    return Scaffold(
      body: Column(
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
                      child: NearbyLocationService.instance?.getImage(
                          widget.landMark.photos![0].photoReference.toString()),
                    ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 40.0),
                child: Row(children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Colors.black,
                    onPressed: () => Navigator.pop(context),)
                ],)
              ,),
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
                        Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "Salaya",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          futureBuilder
          //SizedBox(height: 20.0)//MapSample(place: widget.location)
        ],
      ),
    );
  }

  /// Create a review list for each landmarks
  Widget createReviewListView(BuildContext context, AsyncSnapshot snapshot) {
    Map<String,dynamic> info = snapshot.data;
    List<dynamic> reviews = [];
    if(info.containsKey("reviews")){
      reviews = info["reviews"];
    }else{
      reviews.add({"author_name" : "", "text" : "No Comments"});
    }
    /*
    for(var i = 0; i< reviews.length; i++){
      print(reviews[i]);
    }

     */
    return Expanded(
      child: SizedBox(
        height: 200.0,
        child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (BuildContext, int index){
            return Card(elevation: 0 , child: ListTile(title: Text(reviews[index]["author_name"]),subtitle: Text(reviews[index]["text"]),));
          },
        ),
      ),
    );
  }

}

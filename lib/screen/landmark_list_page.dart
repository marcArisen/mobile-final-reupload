import 'package:flutter/material.dart';
import 'package:project2_mobile_app/api/nearby_landmarks_service.dart';
import 'package:project2_mobile_app/screen/landmark_page.dart';
import 'package:project2_mobile_app/screen/university_page.dart';
import '../model/landmark_model.dart';

class LandmarkListPage extends StatefulWidget {
   const LandmarkListPage({Key? key}) : super(key: key);

  @override
  State<LandmarkListPage> createState() => _LandmarkListPageState();
}

class _LandmarkListPageState extends State<LandmarkListPage> with TickerProviderStateMixin{
  var universityList = [
    "Mahidol University",
    "Chulalongkorn University",
    "Chiangmai University"
  ];
  String selectedUniversity = "Mahidol University";

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    var futureBuilder = FutureBuilder(
      future: NearbyLocationService.instance?.getNearby(selectedUniversity),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return createListView(context, snapshot);
            }
        }
      },
    );
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              DropdownButton(
                  value: selectedUniversity,
                  items: universityList.map((map) {
                    return DropdownMenuItem(
                        value: map,
                        child: Text(map));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUniversity = value.toString();
                    });
                  }),

              Container(
                child: TabBar(
                  controller: _tabController,
                    tabs: [
                      Tab(text: "Restaurant"),
                      Tab(text: "Accommodation")
                    ]
                ),
              ),

              Container(
                width: double.maxFinite,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.76,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    futureBuilder,
                    futureBuilder
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  /// Create ListView for displaying Nearby landmarks
  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Landmark> values = snapshot.data;
    return  ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LandmarkPage(landMark: values[index])));
            },
            child: Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      child: NearbyLocationService.instance?.getImage(
                          values[index].photos![0].photoReference!.toString()),
                    ),
                  ),
                  Positioned(
                      left: 10.0,
                      bottom: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            values[index].name.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          );
        },
    );
  }
}
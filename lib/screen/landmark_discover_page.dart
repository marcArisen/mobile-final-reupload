import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/UniversityRepo/UniversityDatabase.dart';
import 'package:project2_mobile_app/api/nearby_landmarks_service.dart';
import 'package:project2_mobile_app/screen/landmark_page.dart';
import '../model/landmark_model.dart';

/// Page to discover nearby landmarks for each university
class LandMarkDiscoverPage extends StatefulWidget {
  const LandMarkDiscoverPage({Key? key}) : super(key: key);

  @override
  State<LandMarkDiscoverPage> createState() => _LandMarkDiscoverPageState();
}

class _LandMarkDiscoverPageState extends State<LandMarkDiscoverPage>
    with TickerProviderStateMixin {
  var universityList =
      UniversityDatabase.databaseManager.getAllNameUniversities();
  String selectedUniversity = "Mahidol University";

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    ///Restaurant ListView
    var futureRestaurantBuilder = FutureBuilder(
      future: NearbyLocationService.instance
          ?.getNearby(selectedUniversity, "restaurant"),
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

    ///Accommodation ListView
    var futureAccommodationBuilder = FutureBuilder(
      future: NearbyLocationService.instance
          ?.getNearby(selectedUniversity, "accommodation"),
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

    ///Activity ListView
    var futureActivityBuilder = FutureBuilder(
      future: NearbyLocationService.instance
          ?.getNearby(selectedUniversity, "activity"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Discover",
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
                  SizedBox(width: 20.0),
                  Container(
                    height: 50.0,
                    width: 300.0,
                    child: DropdownSearch(
                      mode: Mode.DIALOG,
                      showSearchBox: true,
                      showSelectedItem: true,
                      items: universityList,
                      onChanged: (value) {
                        setState(() {
                          selectedUniversity = value.toString();
                        });
                      },
                      selectedItem: selectedUniversity,
                      dropdownSearchDecoration:
                          (InputDecoration(border: InputBorder.none)),
                    ),
                  ),
                ],
              ),
              TabBar(
                controller: _tabController,
                labelStyle: GoogleFonts.lato(fontSize: 12.0),
                tabs: [
                  Tab(text: "Restaurant",
                      icon: Icon(Icons.restaurant)),
                  Tab(
                    text: "Accommodation",
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    text: "Activity",
                    icon: Icon(Icons.directions_bike),
                  )
                ],
              ),
              SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.73,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    futureRestaurantBuilder,
                    futureAccommodationBuilder,
                    futureActivityBuilder
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
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LandmarkPage(landMark: values[index])));
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
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: NearbyLocationService.instance?.getImage(
                          values[index].photos![0].photoReference!.toString()),
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
                          values[index].name.toString(),
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: values[index].rating!.toDouble(),
                            itemCount: 5,
                            itemBuilder: (context, _) =>
                                Icon(Icons.star, color: Colors.yellow),
                          ),
                          Text(
                            "(${values[index].rating.toString()})",
                            style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

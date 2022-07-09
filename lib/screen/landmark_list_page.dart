import 'package:flutter/material.dart';
import 'package:project2_mobile_app/api/nearby_landmarks_service.dart';
import '../model/landmark_model.dart';

class LandmarkPage extends StatefulWidget {
   const LandmarkPage({Key? key}) : super(key: key);

  @override
  State<LandmarkPage> createState() => _LandmarkPageState();
}

class _LandmarkPageState extends State<LandmarkPage> {
  var universityList = ["mahidol","chulalongkorn"];
  String selectedUniversity = "mahidol";
  @override
  Widget build(BuildContext context) {
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
    return  SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              DropdownButton(
                
                  value: selectedUniversity,
                  items: universityList.map((map){
                    return DropdownMenuItem(
                      value: map,
                      child: Text(map));
                  }).toList(),
                  onChanged: (value){
                    setState((){
                      selectedUniversity = value.toString();
                    });
                  }),
              futureBuilder
            ],
          ),
        ),
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Landmark> values = snapshot.data;
    return  SizedBox(
      height: 600,
      child: ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Card(
                elevation: 0,
                child: ListTile(
                  title: Text(values[index].name.toString()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
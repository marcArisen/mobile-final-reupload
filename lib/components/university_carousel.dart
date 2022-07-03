import 'package:flutter/material.dart';
import 'package:project2_mobile_app/model/university_model.dart';

class UniversityCarousel extends StatelessWidget {
  const UniversityCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Recommend",
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () => print("pressed"),
                child: Text(
                  "See All",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 300.0,
          //color: Colors.blue,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: universities.length,
            itemBuilder: (BuildContext context, int index) {
              University university = universities[index];
              return Container(
                margin: EdgeInsets.all(10.0),
                width: 210.0,
                //color: Colors.red,
                child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[

                  Positioned(
                    bottom: 15.0,
                    child: Container(
                      height: 120.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${university.name}',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0)
                        ]),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image(
                            height: 180.0,
                            width: 180.0,
                            image: AssetImage(university.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              );
            },
          ),
        )
      ],
    );
  }
}

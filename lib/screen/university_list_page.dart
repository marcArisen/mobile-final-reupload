import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/screen/university_page.dart';
import '../UniversityRepo/UniversityDatabase.dart';
import '../api/university_location_service.dart';

class UniversityListPage extends StatefulWidget {
  const UniversityListPage({Key? key}) : super(key: key);

  @override
  State<UniversityListPage> createState() => _UniversityListPageState();
}

class _UniversityListPageState extends State<UniversityListPage> {

  @override
  Widget build(BuildContext context) {
    var universities = UniversityDatabase.universities;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: universities.length,
                itemBuilder: (BuildContext context, int index) {
                  var university = universities[index];
                  return GestureDetector(
                    onTap: () async {
                      String placeId =
                      await LocationService().getPlaceId(university.thaiName!);
                      Map<String, dynamic> m =
                      await LocationService().getPlace(university.name!);
                      double rating = await LocationService().getRating(university.thaiName!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UniversityPage(
                                location: m,
                                university: university,
                                placeId: placeId,
                                rating: rating,
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
                                        image: AssetImage(university.imageUrl.toString()),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 10.0,
                                  bottom: 10.0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        university.name.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),

                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: 5,
                                            itemCount: 5,
                                            itemBuilder: (context, _) =>
                                                Icon(Icons.star, color: Colors.yellow),
                                          ),
                                          Text(
                                            "5",
                                            style: TextStyle(color: Colors.white),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

}

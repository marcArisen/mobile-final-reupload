import 'package:flutter/material.dart';
import 'package:project2_mobile_app/components/university_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1F5FE),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20),
                  child: Icon(Icons.account_box_rounded, size: 80),
                ),
                const Text("Thanawat",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(height: 20.0)
            ,
            const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Explore Thai Universities",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "We combine information you need to know abou Thai universities.",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 20.0),
            UniversityCarousel(),
          ],
        ),
      ),
    );
  }
}

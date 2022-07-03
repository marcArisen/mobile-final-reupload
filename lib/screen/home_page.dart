import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Explore Thai university",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "We combine information you need to know abou Thai universities",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 20.0),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text("Recommend",
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold)),
                      Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.blue),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

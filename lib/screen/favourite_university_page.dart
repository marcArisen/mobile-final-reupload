import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/UniversityRepo/UniversityDatabase.dart';
import '../model/university_model.dart';

class FavouriteUniversityPage extends StatefulWidget {
  const FavouriteUniversityPage({Key? key}) : super(key: key);

  @override
  State<FavouriteUniversityPage> createState() => _FavouriteUniversityPageState();
}

class _FavouriteUniversityPageState extends State<FavouriteUniversityPage> {
  // late final FirebaseAuth _auth = FirebaseAuth.instance;
  // late final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // late String loggedInUser = _auth.currentUser?.email ?? 'none';
  //
  // Future<List> filterUniversities(String user) async {
  //   final list = await _firestore.collection(user).get();
  //   var to_return = [];
  //   for (var ele in list.docs) {
  //     int id = ele.get('id');
  //     to_return.add(id);
  //   }
  //   to_return = to_return.toSet().toList();
  //
  //   var fav_universities = [];
  //   var uni_list = UniversityDatabase.universities;
  //   for (var i = 0; i < to_return.length; i++){
  //     fav_universities.add(uni_list[to_return[i] + 1 ]);
  //   }
  //   return fav_universities;
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Theme.of(context).canvasColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: universities.length,
              itemBuilder: (BuildContext context, int index){
                University university = universities[index];
                return Card(
                  margin: EdgeInsets.only(left:15.0, right: 15.0, bottom: 5.0,top: 10.0),
                  child: ListTile(leading: CircleAvatar(backgroundImage: AssetImage(university.logo)), title: Text(university.name, style: GoogleFonts.lato(fontSize: 16.0, ),textAlign: TextAlign.center,),
                ));
              },
            )
          )
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2_mobile_app/components/favourite_university_list.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final FirebaseAuth _auth = FirebaseAuth.instance;
  late String loggedInUser = _auth.currentUser?.email ?? 'none';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 10),
                    child: Image.asset('assets/icons/profile.png'),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 200,
                          child: Text("Hi,",
                              style: GoogleFonts.lato(
                                  fontSize: 24, fontWeight: FontWeight.bold))),
                      SizedBox(
                          width: 200,
                          child: Text("${loggedInUser}!",
                              style: GoogleFonts.lato(
                                  fontSize: 18, fontWeight: FontWeight.w300)))
                    ],
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {
                    print("hi");
                  },
                  child: Text("Logout"))
            ],
          ),
          SizedBox(height: 20.0),
          Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  SizedBox(width: 18.0),
                  Text("My Favourite University ",
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold, fontSize: 18.0)),
                ],
              )),
          SizedBox(height: 10.0),
          Container(
            height: 500.0,
            child: FavouriteUniversityPage(),
          )
        ],
      ),
    ));
  }
}

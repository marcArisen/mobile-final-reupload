import 'package:flutter/material.dart';
import 'package:project2_mobile_app/screen/favourite_university_page.dart';
import '../components/favourite_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FavouriteUniversityPage(),
    );
  }
}

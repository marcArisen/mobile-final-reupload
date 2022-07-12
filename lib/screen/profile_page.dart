import 'package:flutter/material.dart';
import '../components/favourite_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FavouriteList()
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project2_mobile_app/screen/home_page.dart';
import 'package:project2_mobile_app/screen/main_page.dart';

void main() {
  runApp(const MyApp());
}
// hello
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: MainPage());
  }

}

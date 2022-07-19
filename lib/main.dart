import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project2_mobile_app/UniversityRepo/UniversityDatabase.dart';
import 'package:project2_mobile_app/UniversityRepo/api_puller.dart';
import 'package:project2_mobile_app/api/api_service.dart';
import 'package:project2_mobile_app/provider/theme_provider.dart';
import 'package:project2_mobile_app/screen/authentication_page.dart';
import 'package:project2_mobile_app/screen/main_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initial = await ApiService().getStudents();
  await ApiPuller().updateNumberToDatabase(initial?.result?.records);
  UniversityDatabase.databaseManager.getAllUniversities();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);

      return MaterialApp(
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
          body: LoginScreen(),
        ),
      );
    },
  );

  // @override
  // Widget build(BuildContext context) => ChangeNotifierProvider(
  //   create: (context) => ThemeProvider(),
  //   builder: (context, _) {
  //     final themeProvider = Provider.of<ThemeProvider>(context);
  //
  //     return MaterialApp(
  //       themeMode: themeProvider.themeMode,
  //       theme: MyThemes.lightTheme,
  //       darkTheme: MyThemes.darkTheme,
  //       home: MainPage(),
  //     );
  //   },
  // );

}

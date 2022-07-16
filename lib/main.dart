import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project2_mobile_app/UniversityRepo/UniversityDatabase.dart';
import 'package:project2_mobile_app/UniversityRepo/api_puller.dart';
import 'package:project2_mobile_app/api/api_service.dart';
import 'package:project2_mobile_app/provider/theme_provider.dart';
import 'package:project2_mobile_app/screen/login_page.dart';
import 'package:project2_mobile_app/screen/main_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var test = await ApiService().getStudents();
  UniversityDatabase.databaseManager.getAllUniversities();
  // print(test?.result?.records.runtimeType);
  // print(await ApiPuller().updateNumberToDatabase(test?.result?.records));
  // var temp = await UniversityDatabase.databaseManager.getUniversityList();
  getCurrentLocation();
  runApp(const MyApp());
}
void getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position.longitude);
  print(position.latitude);

  String long = position.longitude.toString();
  String lat = position.latitude.toString();

}
// hello
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
  //       home: Scaffold(
  //         resizeToAvoidBottomInset: true,
  //         backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
  //         body: LoginScreen(),
  //         bottomNavigationBar: BottomAppBar(
  //             color: Colors.transparent,
  //             elevation: 0,
  //             child: Container(
  //               padding: EdgeInsets.all(20),
  //               child: const Text(
  //                 "University Recommender",
  //                 style: TextStyle(color: Colors.white),
  //                 textAlign: TextAlign.center,
  //               ),
  //             )),
  //       ),
  //     );
  //   },
  // );

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);

      return MaterialApp(
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: MainPage(),
      );
    },
  );

}

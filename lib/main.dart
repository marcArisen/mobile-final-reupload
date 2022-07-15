import 'package:flutter/material.dart';
import 'package:project2_mobile_app/UniversityRepo/UniversityDatabase.dart';
import 'package:project2_mobile_app/UniversityRepo/api_puller.dart';
import 'package:project2_mobile_app/api/api_service.dart';
import 'package:project2_mobile_app/provider/theme_provider.dart';
import 'package:project2_mobile_app/screen/main_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var test = await ApiService().getStudents();
  var temp = await UniversityDatabase.databaseManager.getUniversityList();
  UniversityDatabase.databaseManager.getAllUniversities();
  // print(test?.result?.records.runtimeType);
  //print(await ApiPuller().updateNumberToDatabase(test?.result?.records));
  print(temp[1].thaiName);
  print(temp[1].name);
  print(temp[1].numbers);
  runApp(const MyApp());
}
// hello
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
        home: MainPage(),
      );
    },
  );

}

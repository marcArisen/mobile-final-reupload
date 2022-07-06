import 'package:flutter/material.dart';
import 'package:project2_mobile_app/provider/theme_provider.dart';
import 'package:project2_mobile_app/screen/main_page.dart';
import 'package:provider/provider.dart';

void main() {
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

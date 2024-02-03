import 'package:flutter/material.dart';
import 'package:konkan_rail_timetable/screens/home_page_with_bottom_nav_bar.dart';
import 'package:konkan_rail_timetable/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.APPBAR_TITLE_TEXT,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const HomePageWithNavBar(),
    );
  }
}

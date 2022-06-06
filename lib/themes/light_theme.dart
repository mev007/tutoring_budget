import 'package:flutter/material.dart';
import 'package:tutoring_budget/constants.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: MAIN_COLOR,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    // iconTheme: IconThemeData(color: Colors.white)
    // foregroundColor: MAIN_COLOR,
  ),
  fontFamily: 'Comfortaa',
  scaffoldBackgroundColor: FON_COLOR,
  primaryColor: BTT_COLOR,
  // CUSTOMIZE showDatePicker Colors
  colorScheme: const ColorScheme.light(primary: MAIN_COLOR),
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
  // textTheme: const TextTheme(
  // subtitle1: TextStyle(
  //     color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
  //   caption: TextStyle(color: Colors.red),
  // ),
  cardColor: Colors.white,
  brightness: Brightness.light,
  // highlightColor: Colors.transparent,
  highlightColor: ADD_COLOR,
  splashColor: Colors.transparent,
  iconTheme: const IconThemeData(color: MAIN_COLOR), //????
  // progressIndicatorTheme: const ProgressIndicatorThemeData(
  //       linearTrackColor: Color(0xFFFD41B4),
  //       color: Color(0xFF6A05FE),
  //       refreshBackgroundColor: Color(0xFFF37B46)),
  // bottomAppBarColor: Color(0xFFFD41B4),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: BTT_COLOR,
    elevation: 10,
  ),
);

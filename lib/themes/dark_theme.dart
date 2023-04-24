import 'package:flutter/material.dart';
import 'package:tutoring_budget/constants.dart';

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: MAIN_COLOR,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontFamily: 'SofiaSans',
    ),
    iconTheme: IconThemeData(color: Colors.white),
    // foregroundColor: MAIN_COLOR,
  ),
  tooltipTheme: const TooltipThemeData(
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.symmetric(horizontal: 25),
    showDuration: Duration(seconds: 5),
  ),
  fontFamily: 'SofiaSans',
  scaffoldBackgroundColor: Colors.black,
  primaryColor: BTT_COLOR,
  // CUSTOMIZE showDatePicker Colors
  colorScheme: const ColorScheme.dark(primary: Colors.white),
  // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
  //               .copyWith(
  //                   secondary: Colors.blueAccent, brightness: Brightness.dark),
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
  // textTheme: const TextTheme(
  // subtitle1: TextStyle(
  //     color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
  //   caption: TextStyle(color: Colors.red),
  // ),
  cardColor: Colors.grey,
  brightness: Brightness.dark,
  // highlightColor: Colors.transparent,
  highlightColor: ADD_COLOR,
  splashColor: Colors.transparent,
  iconTheme: const IconThemeData(color: Colors.white), //????
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

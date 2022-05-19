import 'package:flutter/material.dart';
import 'package:tutoring_budget/constants.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: MAIN_COLOR,
    centerTitle: false,
    // foregroundColor: MAIN_COLOR,
    // titleTextStyle: TextStyle(fontSize: 14),
  ),
  primaryColor: BTT_COLOR,
  // CUSTOMIZE showDatePicker Colors
  colorScheme: const ColorScheme.light(primary: MAIN_COLOR),
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
  // textTheme: const TextTheme(caption: TextStyle(color: Colors.red)),
  brightness: Brightness.light,
  scaffoldBackgroundColor: FON_COLOR,
  // highlightColor: Colors.transparent,
  highlightColor: ADD_COLOR,
  splashColor: Colors.transparent,
  iconTheme: const IconThemeData(color: MAIN_COLOR),
);

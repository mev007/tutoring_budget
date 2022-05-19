// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

List<String> listCategory = [
  'ЗНО',
  '5 клас',
  '6 клас',
  '7 клас',
  '8 клас',
  '9 клас',
  '10 клас',
];

List<String> listVideo = [
  'Skype',
  'Google Meet',
  'Zoom',
  'Microsoft Teams',
];

const Color MAIN_COLOR = Color(0xFF4a354f);
const Color BTT_COLOR = Color(0xFFc06033); 
const Color ICON_COLOR = Color(0xFFddaf52);
const Color ADD_COLOR = Color(0xFF8e96b0);
const Color FON_COLOR = Color(0xFFFFF1E7);
const Color GREEN_COLOR = Color.fromARGB(255, 4, 154, 4);
const Color EDIT_FON_COLOR = Color(0xFF2A64AB);
const Color DEL_FON_COLOR = Color(0xFFAA3731);
const Color SLIDE_ICON_COLOR = Color(0xFFFFFFFF);
const Color GREY_COLOR = Colors.grey;

const BoxShadow SHADOW = BoxShadow(
  color: Color(0xFFBDBDBD),
  spreadRadius: 5,
  blurRadius: 7,
  offset: Offset(0, 3), // changes position of shadow
);

const STYLE_PARAM = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

const BORDER_DROPDOWN = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(15)),
  borderSide: BorderSide(color: MAIN_COLOR, width: 1),
);

final OUTLINED_BTT_STYLE = OutlinedButton.styleFrom(
  alignment: Alignment.centerLeft,
  side: const BorderSide(color: MAIN_COLOR),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  padding: const EdgeInsets.all(15),
  backgroundColor: const Color.fromRGBO(216, 216, 216, 0.25),
);

const STYLE_DATE =
    TextStyle(color: MAIN_COLOR, fontSize: 16, fontWeight: FontWeight.normal);

final OUTLINED_DT = OutlinedButton.styleFrom(
  alignment: Alignment.centerLeft,
  side: const BorderSide(color: MAIN_COLOR),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  padding: const EdgeInsets.fromLTRB(15, 5, 3, 5),
  backgroundColor: const Color.fromRGBO(216, 216, 216, 0.25),
);
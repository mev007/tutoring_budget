import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';

class MyIcon extends StatelessWidget {
  const MyIcon(this.iconData, {Key? key}) : super(key: key);

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Icon(iconData, color: Get.isDarkMode ? Colors.white : MAIN_COLOR);
  }
}

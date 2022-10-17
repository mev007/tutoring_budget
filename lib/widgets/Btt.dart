// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, prefer_const_declarations
import 'package:flutter/material.dart';
import 'package:tutoring_budget/constants.dart';

class Btt extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  final bool isNegative;
  final IconData? icon;
  final double? sizeTitle;
  final double? minWidht;
  final double height;
  const Btt({
    Key? key,
    this.title = 'Ok',
    required this.onPress,
    this.isNegative = false,
    this.icon,
    this.sizeTitle,
    this.minWidht,
    this.height = 45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: isNegative ? BTT_COLOR : Colors.white,
          backgroundColor: isNegative ? Colors.white : BTT_COLOR,
          side: BorderSide(
              width: 2.0, color: isNegative ? BTT_COLOR : Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          padding: const EdgeInsets.all(10),
          minimumSize:
              minWidht == null ? Size(50, height) : Size(minWidht!, height),
          textStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      onPressed: onPress,
      child: (icon == null)
          ? Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sizeTitle))
          : Icon(icon, color: isNegative ? BTT_COLOR : Colors.white, size: 22),
    );
  }
}

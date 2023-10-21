// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, prefer_const_declarations

import 'package:get/get.dart';

import '../constants.dart';
import 'package:flutter/material.dart';

import 'my_icon.dart';

class BuildTextField extends StatelessWidget {
  final String labelText;
  final bool autofocus;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final int? maxLines;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign textAlign;

  const BuildTextField({
    super.key,
    this.labelText = '',
    this.autofocus = false,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.prefixIcon,
    this.maxLines = 1,
    this.height = 55,
    this.contentPadding,
    this.textAlign = TextAlign.left,
  });
  @override
  Widget build(BuildContext context) {
    final prIcon =
        prefixIcon == null ? null : MyIcon(prefixIcon!);
    // , color: MAIN_COLOR);
    return Container(
      height: height,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(216, 216, 216, 0.25),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        autofocus: autofocus,
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        textAlign: textAlign,
        cursorColor: Get.isDarkMode ? Colors.white : MAIN_COLOR,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelStyle: const TextStyle(color: BTT_COLOR),
          labelStyle: const TextStyle(color: GREY_COLOR),
          prefixIcon: prIcon,
          border: BORDER_DROPDOWN,
          focusedBorder: BORDER_DROPDOWN,
          enabledBorder: BORDER_DROPDOWN,
          errorBorder: BORDER_DROPDOWN,
          disabledBorder: BORDER_DROPDOWN,
          contentPadding: contentPadding,
        ),
        maxLines: maxLines,
      ),
    );
  }
}

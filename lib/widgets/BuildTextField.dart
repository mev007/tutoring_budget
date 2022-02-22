// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, prefer_const_declarations
import '../constants/constants.dart';
import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final int? maxLines;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign textAlign;

  const BuildTextField({
    Key? key,
    this.labelText = '',
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.prefixIcon,
    this.maxLines = 1,
    this.height = 55,
    this.contentPadding,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  final border = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(color: MAIN_COLOR, width: 1),
  );
  @override
  Widget build(BuildContext context) {
    final prIcon =
        prefixIcon == null ? null : Icon(prefixIcon, color: MAIN_COLOR);
    return Container(
      height: height,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(216, 216, 216, 0.25),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        textAlign: textAlign,
        cursorColor: MAIN_COLOR,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelStyle: const TextStyle(color: BTT_COLOR),
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: prIcon,
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          errorBorder: border,
          disabledBorder: border,
          contentPadding: contentPadding,
        ),
        maxLines: maxLines,
      ),
    );
  }
}

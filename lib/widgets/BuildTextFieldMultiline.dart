// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, prefer_const_declarations
import 'package:flutter/material.dart';
import 'package:tutoring_budget/constants.dart';

class BuildTextFieldMultiline extends StatelessWidget {
  final double height;
  final String? labelText;
  final TextEditingController? controller;

  const BuildTextFieldMultiline({
    Key? key,
    this.height = 100,
    this.labelText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(216, 216, 216, 0.25),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        cursorColor: MAIN_COLOR,
        maxLines: 15,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          labelText: labelText,
          prefixIcon: const Icon(Icons.text_fields, color: MAIN_COLOR),
          floatingLabelStyle: const TextStyle(color: BTT_COLOR),
          labelStyle: const TextStyle(color: Colors.grey),
          border: BORDER_DROPDOWN,
          focusedBorder: BORDER_DROPDOWN,
          enabledBorder: BORDER_DROPDOWN,
          errorBorder: BORDER_DROPDOWN,
          disabledBorder: BORDER_DROPDOWN,
        ),
      ),
    );
  }
}

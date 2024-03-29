// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/widgets/custom_appbar.dart';

import 'language_controller.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});
  final LanguageController ctrl = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.check, color: MAIN_COLOR);
    return Scaffold(
      appBar: CustomAppBar(title: 'Language'.tr),
      body: ListView(
        itemExtent: 70,
        children: [
          InkWell(
            onTap: () => ctrl.changeLocate(CurentLanguege.ukrainian),
            splashColor: MAIN_COLOR.withOpacity(0.1),
            child: ListTile(
              title: const Text('Ukrainian'),
              subtitle: const Text(
                'Українська',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              trailing: (ctrl.isCheckViewUA.value) ? icon : null,
            ),
          ),
          InkWell(
            onTap: () => ctrl.changeLocate(CurentLanguege.english),
            splashColor: MAIN_COLOR.withOpacity(0.1),
            child: ListTile(
              title: const Text('English'),
              subtitle: const Text(
                'English',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              trailing: (ctrl.isCheckViewEN.value) ? icon : null,
            ),
          ),
        ],
      ),
    );
  }
}

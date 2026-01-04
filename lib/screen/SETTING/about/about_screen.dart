import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/widgets/custom_appbar.dart';

import 'about_controller.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Про програму'.tr),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Опис програми - абзац 1'.tr),

                const SizedBox(height: 10),
                Text(
                  'Внесені зміни'.tr,
                  style: STYLE_PARAM,
                  textAlign: TextAlign.center,
                ),
                Text('Version 1.3.0', textAlign: TextAlign.right),
                Text('Change Version 1.3.0'.tr),
                Text('Version 1.2.1', textAlign: TextAlign.right),
                Text('Change Version 1.2.1'.tr),

                const SizedBox(height: 15),
                Text('FAQ'.tr, style: STYLE_PARAM, textAlign: TextAlign.center),
                const SizedBox(height: 5),
                Text('question_1'.tr, style: STYLE_QUESTION),
                Text('answer_1'.tr, style: STYLE_ANSWER),
                const SizedBox(height: 5),
                Text('question_2'.tr, style: STYLE_QUESTION),
                Text('answer_2'.tr, style: STYLE_ANSWER),
                const SizedBox(height: 5),
                Text('question_3'.tr, style: STYLE_QUESTION),
                Text('answer_3'.tr, style: STYLE_ANSWER),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/screen/SETTING/support/support_controller.dart';
import 'package:tutoring_budget/widgets/btn.dart';
import 'package:tutoring_budget/widgets/build_text_field.dart';
import 'package:tutoring_budget/widgets/build_text_field_multiline.dart';
import 'package:tutoring_budget/widgets/custom_appbar.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Support'.tr),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BuildTextField(
                  labelText: 'Email subject'.tr,
                  prefixIcon: Icons.topic,
                  controller: ctrl.ctrlSubject,
                ),
                const SizedBox(height: 10),
                BuildTextFieldMultiline(
                  labelText: 'Email text'.tr,
                  controller: ctrl.ctrlBody,
                  height: 150,
                ),
                const SizedBox(height: 10),
                Btn(
                  onPress: () => ctrl.sendMail(),
                  title: 'Send an email'.tr,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

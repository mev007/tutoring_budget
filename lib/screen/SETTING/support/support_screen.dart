import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/screen/SETTING/support/support_controller.dart';
import 'package:tutoring_budget/widgets/Btt.dart';
import 'package:tutoring_budget/widgets/BuildTextField.dart';
import 'package:tutoring_budget/widgets/BuildTextFieldMultiline.dart';
import 'package:tutoring_budget/widgets/custom_appbar.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

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
                Btt(
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

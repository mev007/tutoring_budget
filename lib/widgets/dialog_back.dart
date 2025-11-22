import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/widgets/btn.dart';

class DialogBack extends StatelessWidget {
  const DialogBack({
    super.key,
    this.title,
    this.subtitle,
    this.onCancel,
    this.onConfirm,
  });

  final String? title;
  final String? subtitle;
  final void Function()? onCancel;
  final void Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.all(15),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Text(
            title ?? 'Save'.tr,
            style: STYLE_PARAM,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            subtitle ?? 'SaveExit'.tr,
            // style: ST.subTitle,
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Btn(
                onPress: onCancel ?? () => Get.back(),
                title: 'Do not save'.tr,
                isNegative: true,
              ),
              SizedBox(width: 15),
              Btn(onPress: onConfirm, title: 'Save'.tr),
            ],
          ),
        ],
      ),
    );
  }
}

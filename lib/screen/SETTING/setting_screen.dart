import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/routes/app_routes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        itemExtent: 70,
        children: [
          itemTitle(
            icon: Icons.language,
            title: 'Language'.tr,
            subtitle: 'Select the language'.tr,
            color: Colors.blue,
            onTap: () => Get.toNamed(AppRoutes.LANGUAGE),
          ),
          itemTitle(
            icon: Icons.cast_for_education,
            title: 'Категорія навчання'.tr,
            subtitle: 'ChangeCategory'.tr,
            color: Colors.red,
            onTap: () => Get.toNamed(AppRoutes.CATEGORY),
          ),
          itemTitle(
            icon: Icons.personal_video,
            title: 'Програма спілкування'.tr,
            subtitle: 'ChangeCommunicationProgram'.tr,
            color: Colors.purple,
            onTap: () => Get.toNamed(AppRoutes.COMMUNICATION),
          ),
          // itemTitle(
          //   icon: Icons.done_all,
          //   title: 'EvaluateTitle'.tr,
          //   subtitle: 'EvaluateSubtitle'.tr,
          //   color: Colors.green,
          //   decoration: TextDecoration.lineThrough,
          //   onTap: () {},
          // ),
          itemTitle(
            icon: Icons.contact_support,
            title: 'Support'.tr,
            subtitle: 'SupportSubtitle'.tr,
            color: Colors.orange,
            onTap: () => Get.toNamed(AppRoutes.SUPPORT),
          ),
        ],
      ),
    );
  }

  //#  ===============   ДОДАТКОВІ МЕТОДИ   =================
  Widget itemTitle(
      {IconData? icon,
      required String title,
      String? subtitle,
      Color? color,
      TextDecoration? decoration,
      VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      splashColor: (color ?? MAIN_COLOR).withOpacity(0.1),
      child: ListTile(
        leading: Icon(icon, size: 25, color: color),
        title: Text(title,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                decoration: decoration)),
        subtitle: subtitle == null ? null : Text(subtitle),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 15, color: MAIN_COLOR),
        minVerticalPadding: 2,
        minLeadingWidth: 0,
      ),
    );
  }
}

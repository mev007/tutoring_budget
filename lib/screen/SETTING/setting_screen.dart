import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/routes/app_routes.dart';

import 'setting_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final SettingController ctrl = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          itemTitle(
            icon: Icons.language,
            title: 'Language'.tr,
            subtitle: 'Select the language'.tr,
            color: Colors.green,
            onTap: () => Get.toNamed(AppRoutes.LANGUAGE),
          ),
          itemTitle(
            icon: Icons.cast_for_education,
            title: 'Категорія навчання'.tr,
            subtitle: 'ChangeCategory'.tr,
            color: const Color.fromARGB(255, 63, 190, 249),
            onTap: () => Get.toNamed(AppRoutes.CATEGORY),
          ),
          itemTitle(
            icon: Icons.personal_video,
            title: 'Програма спілкування'.tr,
            subtitle: 'ChangeCommunicationProgram'.tr,
            color: const Color.fromARGB(255, 3, 98, 176),
            onTap: () => Get.toNamed(AppRoutes.COMMUNICATION),
          ),
          itemTitle(
            icon: Icons.contact_support,
            title: 'Support'.tr,
            subtitle: 'SupportSubtitle'.tr,
            color: Colors.purple,
            onTap: () => Get.toNamed(AppRoutes.SUPPORT),
          ),
          itemTitle(
            icon: Icons.ios_share,
            title: 'Share'.tr,
            subtitle: 'ShareSubtitle'.tr,
            color: Colors.red,
            onTap: () {
              if (GetPlatform.isAndroid) {
                Share.share('${'ShareText'.tr}\n$ANDROID_URL');
              } else if (GetPlatform.isIOS) {
                Share.share('${'ShareText'.tr}\n$IPHONE_URL');
              }
            },
          ),
          itemTitle(
            icon: Icons.star,
            title: 'EvaluateTitle'.tr,
            subtitle: 'EvaluateSubtitle'.tr,
            color: Colors.orange,
            onTap: () => StoreRedirect.redirect(
                iOSAppId: '1660052554',
                androidAppId: "com.tutoring.budget.mev"),
          ),
          itemTitleSwitch(
            icon: CupertinoIcons.moon_stars_fill,
            title: 'ThemeTitle'.tr,
            subtitle: 'ThemeSubtitle'.tr,
            color: Colors.brown,
            // onTap: () => StoreRedirect.redirect(),
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
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 80),
        child: ListTile(
          leading: Icon(icon, size: 25, color: color),
          title: Text(title,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  decoration: decoration)),
          subtitle: subtitle == null
              ? null
              : Text(
                  subtitle,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 15, color: MAIN_COLOR),
          // minVerticalPadding: 2,
          minLeadingWidth: 0,
        ),
      ),
    );
  }

  Widget itemTitleSwitch(
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
        isThreeLine: true,
        leading: Icon(icon, size: 25, color: color),
        title: Text(title,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                decoration: decoration)),
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
        trailing: Obx(() => CupertinoSwitch(
              activeColor: color,
              value: ctrl.valSwitch.value,
              onChanged: ctrl.onChangeSwitch,
            )),
        minVerticalPadding: 2,
        minLeadingWidth: 0,
      ),
    );
  }
}

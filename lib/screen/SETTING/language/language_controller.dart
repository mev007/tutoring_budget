// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names
import 'dart:ui';

import 'package:get/get.dart';
import 'package:tutoring_budget/sp.dart';

enum CurentLanguege {
  ukrainian,
  english,
}

class LanguageController extends GetxController {
  RxBool isCheckViewUA = false.obs;
  RxBool isCheckViewEN = false.obs;

  @override
  void onInit() {
    initCheckLanguage();
    super.onInit();
  }

  void initCheckLanguage() {
    isCheckViewUA.value = (Get.locale == const Locale('uk'));
    isCheckViewEN.value = (Get.locale == const Locale('en'));
  }

  void changeLocate(CurentLanguege locate) {
    switch (locate) {
      case CurentLanguege.ukrainian:
        Get.updateLocale(const Locale('uk'));
        SP.curentLanguage = 'uk';
        break;
      case CurentLanguege.english:
        Get.updateLocale(const Locale('en'));
        SP.curentLanguage = 'en';
        break;
    }
    initCheckLanguage();
  }

}
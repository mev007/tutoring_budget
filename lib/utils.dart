import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'constants/constants.dart';

class Utils {
  ///01.01.2021 15:00
  static String getDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
  }

  ///01.01.2021
  static String getDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  ///15:00
  static String getTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('HH:mm').format(dateTime);
  }

  ///15:00
  static String getTimeString(TimeOfDay? t) {
    if (t == null) return '';
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, t.hour, t.minute);
    return DateFormat('HH:mm').format(dateTime);
  }

  /// 2021 Feb 01
  static String getDate2(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('yyyy MMM dd').format(dateTime);
  }

  ///2022-02-03T13:25:10.324Z
  static String getDateTimeReq(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z").format(dateTime);
  }

  static void messageError(String message) {
    Get.defaultDialog(title: 'Error'.tr, middleText: message, actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            minimumSize: const Size(80, 40),
            primary: Colors.red,
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        onPressed: () => Get.back(),
        child: const Text('Ok'),
      )
    ]);
  }

  static void snackbarError(String message) {
    Get.snackbar(
      'Error'.tr,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void snackbarCheck(String message) {
    Get.snackbar(
      'Message'.tr,
      message,
      icon: const Icon(Icons.task_alt, color: Colors.white),
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.TOP,
    );
  }

  static Widget changeLocateBtt() {
    return TextButton(
      onPressed: () {
        final locale = Get.locale == const Locale('en', 'US')
            ? const Locale('uk', 'UA')
            : const Locale('en', 'US');
        // var locale = Locale('en', 'US');
        Get.updateLocale(locale);
      },
      child: const Text(
        'en/ua',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  ///Видає рандомний набір великих лат.літер і цифр заданої кількості [len]
  static String rndString(int len) {
    var r = Random.secure();
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  static DateTime integerToDateTime(int number) =>
      DateTime.fromMillisecondsSinceEpoch(number);

  static int integerFromDateTime(DateTime dt) => dt.millisecondsSinceEpoch;
}

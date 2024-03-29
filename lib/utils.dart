import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tutoring_budget/screen/board/board_controller.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/widgets/Btt.dart';

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
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.red,
            elevation: 5,
            minimumSize: const Size(80, 40),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        onPressed: () => Get.back(),
        child: const Text('Ok'),
      )
    ]);
  }

  static void messageErrorAddStudent() {
    Get.defaultDialog(
        title: 'Error'.tr,
        middleText: 'Список студентів порожній'.tr,
        actions: [
          Btt(
            onPress: () => Get.back(),
            title: 'Cancel'.tr,
            isNegative: true,
          ),
          Btt(
            onPress: () {
              Get.back();
              Get.find<BoardController>().changeTabIndex(0);
              Get.find<StudentController>().gotoAddStudent();
              
            },
            title: 'Add'.tr,
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

  ///Видає рандомний набір великих лат.літер і цифр заданої кількості [len]
  static String rndString(int len) {
    var r = Random.secure();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  static DateTime integerToDateTime(int number) =>
      DateTime.fromMillisecondsSinceEpoch(number);

  static int integerFromDateTime(DateTime? dt) {
    if (dt == null) {
      return 0;
    } else {
      return dt.millisecondsSinceEpoch;
    }
  }

  static DateTime withoutTime(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day);

  /// Визначає ДАТУ початку тижня
  static DateTime startWeek(DateTime dateTime) {
    final countDay = dateTime.weekday - 1;
    return dateTime.subtract(Duration(days: countDay));
  }

  /// Визначає ДАТУ кінця тижня
  static DateTime endWeek(DateTime dateTime) {
    final countDay = 7 - dateTime.weekday;
    return dateTime.add(Duration(days: countDay));
  }
}

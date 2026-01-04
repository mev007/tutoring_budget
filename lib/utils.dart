import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tutoring_budget/screen/board/board_controller.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/widgets/btn.dart';

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

  static void messageError(String message) {
    Get.defaultDialog(
      title: 'Error'.tr,
      middleText: message,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.red,
            elevation: 0,
            minimumSize: const Size(80, 40),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Get.back(),
          child: const Text('Ok', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  static void messageErrorAddStudent() {
    Get.defaultDialog(
      title: 'Error'.tr,
      middleText: 'Список студентів порожній'.tr,
      actions: [
        Btn(onPress: () => Get.back(), title: 'Cancel'.tr, isNegative: true),
        Btn(
          onPress: () {
            Get.back();
            Get.find<BoardController>().changeTabIndex(0);
            Get.find<StudentController>().gotoAddStudent();
          },
          title: 'Add'.tr,
        ),
      ],
    );
  }

  static void showSnackBarCheck(BuildContext context, String message) {
    info('$message => showSnackBarCheck');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
        showCloseIcon: true,
        elevation: 0,
        duration: const Duration(seconds: 3),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.task_alt, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message, style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  static void info(String message) {
    debugPrint('🟢 \t$message');
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

  static void error(String message, {String? znak}) {
    final time = DateTime.now();
    debugPrint('${znak ?? '❌'} $time  $message');
  }
}

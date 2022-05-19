import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tutoring_budget/constants/constants.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/lessons_model.dart';
import 'package:tutoring_budget/routes/app_routes.dart';
import 'package:tutoring_budget/screen/finance/finance_controll.dart';

class LessonsController extends GetxController {
  /// Список занять
  List<LessonsModel> listLessons = <LessonsModel>[];

  @override
  onInit() async {
    await getListLessons();
    super.onInit();
  }

  /// Отримання списку модельок уроків
  Future getListLessons() async {
    final response = await DB.queryDateBetween(
      LessonsModel.nameTable,
      'dateTime',
      DateTime(selDay.year, selDay.month, selDay.day, 0, 0),
      DateTime(selDay.year, selDay.month, selDay.day, 23, 59),
    );
    if (response == null) return;
    listLessons = response.map((e) => LessonsModel.fromMap(e)).toList();

    if (listLessons.length > 1) {
      listLessons.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }

    for (var item in listLessons) {
      final sum = await sumPayment(item.idStudent, item.dateTime);
      item.balance = sum;
    }
    update();
  }

  ///Перехід до EditLessonScreen
  gotoEditLesson(LessonsModel item) {
    Get.toNamed(AppRoutes.EDIT_LESSON, arguments: item)?.then((result) async {
      final isReloadStudent = result as bool?;
      if (isReloadStudent != null && isReloadStudent) {
        await getListLessons();
      }
    });
  }

  /// Видалення запису
  Future deleteLesson(int index) async {
    final lessonId = listLessons[index].id;
    Get.defaultDialog(
      title: 'Delete'.tr,
      titleStyle:
          const TextStyle(color: DEL_FON_COLOR, fontWeight: FontWeight.bold),
      middleText: 'DeleleRecord?'.tr,
      textCancel: 'Cancel'.tr,
      cancelTextColor: MAIN_COLOR,
      textConfirm: 'Ok',
      confirmTextColor: Colors.white,
      buttonColor: MAIN_COLOR,
      onConfirm: () async {
        await DB.deleteFromId(LessonsModel.nameTable, lessonId);
        listLessons.removeAt(index);
        Get.back();
        update();
      },
    );
  }

  /// Отримання запланованих занять по заданому idStudent за заданий період
  Future<List<LessonsModel>?> totalPayment(
      {String? idStudent, DateTime? fromDateTime, DateTime? toDateTime}) async {
    final response = await DB.totalPayment(
      'Lessons',
      listIdStudent: idStudent == null ? null : [idStudent],
      fromDate: fromDateTime,
      toDate: toDateTime,
    );
    if (response == null) return null;
    return response.map((e) => LessonsModel.fromMap(e)).toList();
  }

  /// Отримання суми проплат по заданому idStudent
  Future<double> sumPayment(String idStudent, DateTime toDateTime) async {
    final listFinance =
        await Get.find<FinanceController>().totalPayment(idStudent: idStudent);
    double sumFinance = 0;
    if (listFinance != null) {
      for (var element in listFinance) {
        sumFinance += element.sum;
      }
    }
    final listLessons =
        await totalPayment(idStudent: idStudent, toDateTime: toDateTime);
    double sumLessons = 0;
    if (listLessons != null) {
      for (var element in listLessons) {
        sumLessons += element.cost;
      }
    }
    return sumFinance - sumLessons;
  }

  /// Перехід до AddLessonScreen
  gotoAddLesson() {
    Get.toNamed(AppRoutes.ADD_LESSON)
        ?.then((_) async => await getListLessons());
  }

  //# ===== КАЛЕНДАР =======
  /// Вибрана дата
  DateTime selDay = DateTime.now();

  /// Дата для фокусування
  DateTime focusedDay = DateTime.now();

  /// Дата початку діапазону
  final kFirstDay = DateTime(DateTime.now().year - 1, DateTime.now().month, 1);

  /// Дата кінця діапазону
  final kLastDay = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  CalendarFormat calendarFormat = CalendarFormat.twoWeeks;

  /// Вибрали дату
  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(selDay, selectedDay)) {
      selDay = selectedDay;
      this.focusedDay = focusedDay;
      getListLessons().then((_) => update());
    }
  }

  /// Змінює формат відображення календаря
  onFormatChanged(CalendarFormat format) {
    if (calendarFormat != format) {
      calendarFormat = format;
      update();
    }
  }
}

// @override
// void onDetached() {
//   print('object');
// }

// @override
// void onInactive() {
//   print('object');
// }

// @override
// void onPaused() {
//   print('object');
// }

// @override
// void onResumed() {
//   print('object');
// }

// @override
// Future<bool> didPopRoute() {
//   print('object');
//   return super.didPopRoute();
// }

// @override
// void didChangeAccessibilityFeatures() {
//   print('object');
//   super.didChangeAccessibilityFeatures();
// }

// @override
// void didChangeMetrics() {
//   print('object');
//   super.didChangeMetrics();
// }

// @override
// void didChangePlatformBrightness() {
//   print('object');
//   super.didChangePlatformBrightness();
// }

// @override
// void didChangeTextScaleFactor() {
//   print('object');
//   super.didChangeTextScaleFactor();
// }

// @override
// Future<bool> didPushRoute(String route) {
//  print('object');
//   return super.didPushRoute(route);
// }

// @override
// void didHaveMemoryPressure() {
//  print('object');
//   super.didHaveMemoryPressure();
// }
// @override
// void disposeId(Object id) {
//   print('object');
//   super.disposeId(id);
// }

// @override
// void dispose() {
//  print('object');
//   super.dispose();
// }

// @override
// void onClose() {
//   print('object');
//   super.onClose();
// }

// @override
// void onReady() {
//   print('object');
//   super.onReady();
// }

// @override
// // TODO: implement onStart
// InternalFinalCallback<void> get onStart {
//   print('dfghdfgdfgdfgdfg');
//   return super.onStart;
// }

// @override
// // TODO: implement onDelete
// InternalFinalCallback<void> get onDelete {
//   print('object');
//   return super.onDelete;
// }

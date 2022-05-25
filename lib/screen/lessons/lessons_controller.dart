import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/lessons_model.dart';
import 'package:tutoring_budget/routes/app_routes.dart';
import 'package:tutoring_budget/screen/FINANCES/finance_controll.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/utils.dart';

class LessonsController extends GetxController {
  /// Список занять
  List<LessonsModel> listLessons = <LessonsModel>[];
  Map<DateTime, int> mapMarket = {};

  @override
  onInit() async {
    await getListLessons();
    await builMarker();
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
        builMarker();
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
        await getListLessons();
        builMarker();
        Get.back();
      },
    );
  }

  /// Видалення декілька записів
  Future deleteAllFromDate(int index, String nameStudent) async {
    final idStudent = listLessons[index].idStudent;
    final lessonId = listLessons[index].dateTime;
    Get.defaultDialog(
      title: 'Delete'.tr,
      titleStyle:
          const TextStyle(color: DEL_FON_COLOR, fontWeight: FontWeight.bold),
      middleText: 'DeleleManyRecord'.tr +
          '\n$nameStudent\n' +
          'after'.tr +
          ' ${Utils.getDateTime(lessonId)}',
      textCancel: 'Cancel'.tr,
      cancelTextColor: MAIN_COLOR,
      textConfirm: 'Ok',
      confirmTextColor: Colors.white,
      buttonColor: MAIN_COLOR,
      onConfirm: () async {
        final countDelRecords = await DB.deleteAllFromDate(lessonId, idStudent);
        await getListLessons();
        builMarker();
        Get.back();
        Utils.snackbarCheck(
            'Видалено записів:'.tr + ' $countDelRecords ' + 'шт'.tr);
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
    if (Get.find<StudentController>().listStudent.isEmpty) {
      Utils.messageError('Список студентів порожній'.tr);
    } else {
      Get.toNamed(AppRoutes.ADD_LESSON)?.then((countRecords) async {
        await getListLessons();
        builMarker();
        if (countRecords != null) {
          Utils.snackbarCheck('Успішно добавлено записи:'.tr +
              ' ${countRecords as int} ' +
              'шт'.tr);
        }
      });
    }
  }

  /// Побудова маркерів кількості занять на день
  Future<void> builMarker() async {
    final firstDayOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
    final lastDayOfMonth = DateTime(focusedDay.year, focusedDay.month + 1, 1)
        .subtract(const Duration(days: 1));
    final startDate = Utils.startWeek(firstDayOfMonth);
    final endDate = Utils.endWeek(lastDayOfMonth);
    final tempList =
        await DB.totalPayment('Lessons', fromDate: startDate, toDate: endDate);
    var currentDate = Utils.withoutTime(startDate);
    mapMarket = {};
    while (!currentDate.isAfter(endDate)) {
      final count = tempList
          ?.where((e) {
            final ddd = LessonsModel.fromMap(e);
            return Utils.withoutTime(ddd.dateTime) == currentDate;
          })
          .toList()
          .length;
      if (count != null && count != 0) {
        mapMarket[currentDate] = count;
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
    update();
  }

  //# ===== КАЛЕНДАР =======
  /// Вибрана дата
  DateTime selDay = DateTime.now();

  /// Дата для фокусування
  DateTime focusedDay = DateTime.now();

  // /// Дата для створення маркерів
  // DateTime markerDay = DateTime.now();

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

  /// Змінює формат відображення календаря
  onPageChanged(DateTime date) {
      focusedDay = date;
      builMarker();
  }
}

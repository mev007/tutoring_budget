// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/lessons_model.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/lessons/lessons_controller.dart';
import 'package:tutoring_budget/utils.dart';
import 'package:uuid/uuid.dart';

class AddLessonController extends GetxController {
  // List<StudentModel> listStudent = <StudentModel>[].obs;

  /// Вибраний студент
  StudentModel? selectStudent;

  /// Вибрана дата та час
  Rx<DateTime> selDate = DateTime.now().obs;
  Rx<TimeOfDay> selTime = TimeOfDay.now().obs;

  /// Чи встановлений Checkbox
  var isCheckbox = false.obs;

  /// Дата періоду
  Rx<DateTime> fromDateTime = DateTime.now().obs;
  Rx<DateTime> toDateTime = DateTime.now().obs;

  /// Контроллер для вартості заняття
  final costNameController = TextEditingController();

  /// Назва дня повторення
  var nameDay = ''.obs;

  @override
  onInit() async {
    // await getListStudent();
    // initDate = Get.find<LessonsController>().selDay;
    // initTime = DateTime.now();
    selDate.value = Get.find<LessonsController>().selDay;
    selTime.value = TimeOfDay(hour: selTime.value.hour, minute: 0);
    fromDateTime.value = Get.find<LessonsController>().selDay;
    toDateTime.value = fromDateTime.value.add(const Duration(days: 150));
    definitionNameDay();
    update();
    super.onInit();
  }

  @override
  void onClose() {
    costNameController.dispose();
    super.onClose();
  }

  /// Отримання списку модельок студентів
  // Future getListStudent() async {
  //   final response = await DB.query(StudentModel.nameTable);
  //   if (response == null) return;
  //   listStudent = response.map((e) => StudentModel.fromMap(e)).toList();
  //   listStudent.sort((a, b) => -a.firstName.compareTo(b.firstName));
  //   update();
  // }

  /// Подія вибору студента
  onChangeStudent(StudentModel item) {
    selectStudent = item;
    costNameController.text = item.cost.toStringAsFixed(0);
    update();
  }

  /// Визначення назви ДНЯ для [nameDay]
  definitionNameDay() {
    switch (selDate.value.weekday) {
      case 1:
        nameDay.value = 'Понеділок'.tr;
        break;
      case 2:
        nameDay.value = 'Вівторок'.tr;
        break;
      case 3:
        nameDay.value = 'Середа'.tr;
        break;
      case 4:
        nameDay.value = 'Четвер'.tr;
        break;
      case 5:
        nameDay.value = 'П\'ятниця'.tr;
        break;
      case 6:
        nameDay.value = 'Субота'.tr;
        break;
      case 7:
        nameDay.value = 'Неділя'.tr;
        break;
    }
  }

  // onDateChange(picked) {
  //   selectDate = picked;
  //   initDate = picked;
  //   update();
  // }

  // onTimeChange(picked) {
  //   selectTime = picked;
  //   initTime = picked;
  //   update();
  // }

  /// Збереження
  onSave() async {
    if (selectStudent == null) {
      Utils.messageError('Імя учня не повинно бути пустим'.tr);
      return;
    }
    double cost = 0.0;
    if (costNameController.text.trim().isEmpty) {
      cost = 0.0;
    } else if (double.tryParse(costNameController.text.trim()) == null) {
      Utils.messageError('Не коректно задана ціна'.tr);
      return;
    } else {
      cost = double.tryParse(costNameController.text.trim())!;
    }

    if (isCheckbox.value == true) {
      await Get.defaultDialog(
        title: 'Добавлення набору записів'.tr,
        titleStyle:
            const TextStyle(color: DEL_FON_COLOR, fontWeight: FontWeight.bold),
        middleText: 'AddRecords'.tr,
        textCancel: 'Cancel'.tr,
        cancelTextColor: MAIN_COLOR,
        textConfirm: 'Ok',
        confirmTextColor: Colors.white,
        buttonColor: MAIN_COLOR,
        onConfirm: () async {
          DateTime dateTime = DateTime(
              fromDateTime.value.year,
              fromDateTime.value.month,
              fromDateTime.value.day,
              selTime.value.hour,
              selTime.value.minute);
          while (dateTime.weekday != selDate.value.weekday) {
            dateTime = dateTime.add(const Duration(days: 1));
          }
          while (Utils.integerFromDateTime(dateTime) <=
              Utils.integerFromDateTime(toDateTime.value)) {
            final lesson = LessonsModel(
              id: const Uuid().v1(),
              dateTime: dateTime,
              idStudent: selectStudent!.id,
              cost: cost,
            );
            print('>>> ${dateTime.toString()}');
            await DB.insert(LessonsModel.nameTable, lesson);
            dateTime = dateTime.add(const Duration(days: 7));
          }
          Get.back();
        },
      );
      Get.back();
      Utils.snackbarCheck('Записи успішно добавлено'.tr);
    } else {
      final dateTime = DateTime(selDate.value.year, selDate.value.month,
          selDate.value.day, selTime.value.hour, selTime.value.minute);
      final lesson = LessonsModel(
        id: const Uuid().v1(),
        dateTime: dateTime,
        idStudent: selectStudent!.id,
        cost: cost,
      );
      await DB.insert(LessonsModel.nameTable, lesson);
      Get.back();
      Utils.snackbarCheck('Записи успішно добавлено'.tr);
    }
  }
}

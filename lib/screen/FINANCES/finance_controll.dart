import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/finances_model.dart';
import 'package:tutoring_budget/routes/app_routes.dart';
import 'package:tutoring_budget/screen/lessons/lessons_controller.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/utils.dart';

class FinanceController extends GetxController {
  /// Список проплат
  List<FinanceModel> listFinance = <FinanceModel>[].obs;
  List<String>? listStudentFilter;
  DateTime? fromDate;
  DateTime? toDate;
  var sum = 0.0;

  String titleStudent = '';
  String titleCategor = '';
  String titleVideo = '';
  String titleDate = '';

  @override
  onInit() async {
    await getListFinance();
    super.onInit();
  }

  /// Отримання списку модельок проплат
  Future getListFinance() async {
    final response = await DB.totalPayment(
      'Finances',
      listIdStudent: listStudentFilter,
      fromDate: fromDate,
      toDate: toDate,
    );
    if (response == null) {
      listFinance = [];
    } else {
      listFinance = response.map((e) => FinanceModel.fromMap(e)).toList();
      listFinance.sort((a, b) => -a.dateTime.compareTo(b.dateTime));
    }
    sum = 0.0;
    for (var item in listFinance) {
      sum += item.sum;
    }
    update();
  }

  /// Перехід до AddFinanceScreen
  gotoAddFinance() {
    if (Get.find<StudentController>().listStudent.isEmpty) {
      Utils.messageErrorAddStudent();
    } else {
      Get.toNamed(AppRoutes.ADD_FINANCE)
          ?.then((_) async => await getListFinance());
    }
  }

  /// Видалення запису
  Future deleteStudent(int index) async {
    final financeId = listFinance[index].id;
    Get.defaultDialog(
      title: 'Delete'.tr,
      titleStyle:
          const TextStyle(color: DEL_FON_COLOR, fontWeight: FontWeight.bold),
      middleText: 'DeleleRecord?'.tr,
      textCancel: 'Cancel'.tr,
      cancelTextColor: BTT_COLOR,
      textConfirm: 'Ok',
      confirmTextColor: Colors.white,
      buttonColor: BTT_COLOR,
      onConfirm: () async {
        await DB.deleteFromId(FinanceModel.nameTable, financeId);
        // listFinance.removeAt(index);
        await getListFinance();
        await Get.find<LessonsController>().getListLessons();
        Get.back();
        // update();
      },
    );
  }

  /// Отримання проплат по заданому idStudent за заданий період
  Future<List<FinanceModel>?> totalPayment(
      {String? idStudent, DateTime? fromDateTime, DateTime? toDateTime}) async {
    final response = await DB.totalPayment(
      'Finances',
      listIdStudent: idStudent == null ? null : [idStudent],
      fromDate: fromDateTime,
      toDate: toDateTime,
    );
    if (response == null) return null;
    return response.map((e) => FinanceModel.fromMap(e)).toList();
  }

  /// Перевірка що параметри про фільтрування ПУСТО
  bool isEmptyParamInfo() {
    if (titleStudent.isEmpty &&
        titleCategor.isEmpty &&
        titleVideo.isEmpty &&
        titleDate.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/routes/app_routes.dart';

class StudentController extends GetxController {
  /// Список студенітв
  List<StudentModel> listStudent = <StudentModel>[].obs;

  @override
  onInit() async {
    await getListStudent();
    super.onInit();
  }

  /// Отримання списку модельок студентів
  Future getListStudent() async {
    final response = await DB.query(StudentModel.nameTable);
    if (response == null) return;
    listStudent = response.map((e) => StudentModel.fromMap(e)).toList();
    listStudent.sort((a, b) => a.firstName.compareTo(b.firstName));
    update();
  }

  /// Видалення запису
  Future deleteStudent(int index) async {
    final studentId = listStudent[index].id;
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
        await DB.deleteFromId(StudentModel.nameTable, studentId);
        listStudent.removeAt(index);
        Get.back();
        update();
      },
    );
  }

  ///Перехід до StudentDetailScreen
  gotoEditStudent(StudentModel item) {
    Get.toNamed(AppRoutes.EDIT_STUDENT, arguments: item)?.then((result) async {
      final isReloadStudent = result as bool?;
      if (isReloadStudent != null && isReloadStudent) {
        await getListStudent();
      }
    });
  }

  /// Перехід до AddStudentScreen
  gotoAddStudent() {
    Get.toNamed(AppRoutes.ADD_STUDENT)
        ?.then((_) async => await getListStudent());
  }

  /// Детальніше про студента
  gotoDetailStudent(item) {
    Get.toNamed(AppRoutes.DETAIL_STUDENT, arguments: item);
  }

  /// Пошук StudentModel по id
  StudentModel? searchStudentModel(String id) {
    try {
      return listStudent.firstWhere((element) => element.id == id);
    } on Exception catch (e) {
      log('$e');
      return null;
    }
  }
}

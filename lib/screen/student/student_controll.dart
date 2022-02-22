import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants/constants.dart';
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
    // listStudent.sort((a, b) => -a.firstName.compareTo(b.firstName));
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
      cancelTextColor: MAIN_COLOR,
      textConfirm: 'Ok',
      confirmTextColor: Colors.white,
      buttonColor: MAIN_COLOR,
      onConfirm: () async {
        await DB.deleteFromId(StudentModel.nameTable, studentId);
        listStudent.removeAt(index);
        Get.back();
        update();
      },
    );
  }

  ///Перехід до StudentDetailScreen
  gotoStudentDetail(StudentModel item) async {
    // final isReloadTest =
    //     await Get.toNamed(AppRoutes.TEACHER_TEST_DETAIL, arguments: item);
    // if (isReloadTest != null && isReloadTest) getListTests();
  }

  /// Перехід до AddStudentScreen
  gotoAddStudent() {
    Get.toNamed(AppRoutes.ADD_STUDENT)
        ?.then((_) async => await getListStudent());
  }

  
}

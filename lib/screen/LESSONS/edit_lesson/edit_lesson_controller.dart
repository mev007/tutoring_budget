import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/lessons_model.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/utils.dart';

class EditLessonController extends GetxController {
  late LessonsModel lesson;
  late String id;

  /// Вибраний студент
  StudentModel? selectStudent;

  /// Вибрана дата та час
  Rx<DateTime> selDate = DateTime.now().obs;
  Rx<TimeOfDay> selTime = TimeOfDay.now().obs;

  /// Контроллер для вартості заняття
  final costNameController = TextEditingController();

  /// Подія вибору студента
  void onChangeStudent(StudentModel item) {
    selectStudent = item;
    costNameController.text = item.cost.toStringAsFixed(0);
    update();
  }

  /// Збереження
  Future<void> onSave(BuildContext context) async {
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

    final dateTime = DateTime(
      selDate.value.year,
      selDate.value.month,
      selDate.value.day,
      selTime.value.hour,
      selTime.value.minute,
    );
    final lesson = LessonsModel(
      id: id,
      dateTime: dateTime,
      idStudent: selectStudent!.id,
      cost: cost,
    );
    await DB.update(LessonsModel.nameTable, lesson);
    Get.back(result: true);
    if (context.mounted) {
      Utils.showSnackBarCheck(context, 'Запис успішно оновлено'.tr);
    }
  }

  @override
  onInit() async {
    lesson = Get.arguments as LessonsModel;
    id = lesson.id;
    selectStudent = Get.find<StudentController>().searchStudentModel(
      lesson.idStudent,
    );
    costNameController.text = lesson.cost.toStringAsFixed(0);
    selDate.value = lesson.dateTime;
    selTime.value = TimeOfDay.fromDateTime(lesson.dateTime);

    update();
    super.onInit();
  }

  @override
  void onClose() {
    costNameController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/finances_model.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/lessons/lessons_controller.dart';
import 'package:tutoring_budget/utils.dart';
import 'package:uuid/uuid.dart';

class AddFinanceController extends GetxController {
  /// Вибраний студент
  StudentModel? selectStudent;

  /// Вибрана дата
  Rx<DateTime> selDate = DateTime.now().obs;

  /// Контроллер для вартості заняття
  final sumNameController = TextEditingController();

  @override
  void onClose() {
    sumNameController.dispose();
    super.onClose();
  }

  /// Подія вибору студента
  void onChangeStudent(StudentModel item) {
    selectStudent = item;
    sumNameController.text = item.cost.toStringAsFixed(0);
    update();
  }

  /// Збереження
  Future<void> onSavesss(BuildContext context) async {
    if (selectStudent == null) {
      Utils.messageError('Імя учня не повинно бути пустим'.tr);
      return;
    }
    double sum = 0.0;
    if (double.tryParse(sumNameController.text.trim()) == null) {
      Utils.messageError('Не коректно задана сума'.tr);
      return;
    } else {
      sum = double.tryParse(sumNameController.text.trim())!;
      if (sum <= 0) {
        Utils.messageError('Сума повинна бути додатня'.tr);
        return;
      }
    }
    final lesson = FinanceModel(
      id: const Uuid().v1(),
      dateTime: selDate.value,
      idStudent: selectStudent!.id,
      sum: sum,
    );
    await DB.insert(FinanceModel.nameTable, lesson);
    await Get.find<LessonsController>().getListLessons();
    Get.back();
    if (context.mounted) {
      Utils.showSnackBarCheck(context, 'Записи добавлено успішно'.tr);
    }
  }
}

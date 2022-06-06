import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/sp.dart';
import 'package:tutoring_budget/utils.dart';

class EditStudentController extends GetxController {
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final adressNameController = TextEditingController();
  final costNameController = TextEditingController();
  final noteNameController = TextEditingController();

  late String id;

  var student = StudentModel();

  String? selectCategory;
  String? selectVideo;

  @override
  void onInit() {
    student = Get.arguments as StudentModel;
    id = student.id;
    lastNameController.text = student.lastName;
    firstNameController.text = student.firstName;
    adressNameController.text = student.adress;
    costNameController.text = student.cost.toStringAsFixed(0);
    noteNameController.text = student.note;
    selectCategory =
        SP.findItemCategory(student.category) ? student.category : null;
    selectVideo = SP.findItemVideo(student.video) ? student.video : null;
    update();
    super.onInit();
  }

  @override
  void onClose() {
    lastNameController.dispose();
    firstNameController.dispose();
    adressNameController.dispose();
    costNameController.dispose();
    noteNameController.dispose();
    super.onClose();
  }

  onChangeCategory(String item) {
    selectCategory = item;
    update();
  }

  onChangeVideo(String item) {
    selectVideo = item;
    update();
  }

  onSave() async {
    if (firstNameController.text.trim().isEmpty) {
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
    if (selectCategory == null) {
      Utils.messageError('Виберіть категорію навчання'.tr);
      return;
    }
    if (selectVideo == null) {
      Utils.messageError('Виберіть програму спілкування'.tr);
      return;
    }
    final student = StudentModel(
      id: id,
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      adress: adressNameController.text.trim(),
      category: selectCategory!,
      video: selectVideo!,
      cost: cost,
      note: noteNameController.text.trim(),
    );
    await DB.insert(StudentModel.nameTable, student);
    Get.back(result: true);
  }
}

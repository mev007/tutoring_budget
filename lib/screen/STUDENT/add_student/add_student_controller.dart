import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/sp.dart';
import 'package:tutoring_budget/utils.dart';
import 'package:uuid/uuid.dart';

class AddStudentController extends GetxController {
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final adressNameController = TextEditingController();
  final costNameController = TextEditingController();
  final noteNameController = TextEditingController();

  String selectCategory = '';

  String selectVideo = '';

  @override
  void onInit() {
    selectCategory = SP.listCategory.first;
    selectVideo = SP.listVideo.first;
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
    final student = StudentModel(
      id: const Uuid().v1(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      adress: adressNameController.text.trim(),
      category: selectCategory,
      video: selectVideo,
      cost: cost,
      note: noteNameController.text.trim(),
    );
    await DB.insert(StudentModel.nameTable, student);
    Get.back();
  }

  onChangeCategory(String item) {
    selectCategory = item;
    update();
  }

  onChangeVideo(String item) {
    selectVideo = item;
    update();
  }
}

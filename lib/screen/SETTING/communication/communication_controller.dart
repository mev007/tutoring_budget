import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/widgets/dialog_back.dart';
import 'package:tutoring_budget/sp.dart';
import 'package:tutoring_budget/utils.dart';
import 'package:tutoring_budget/widgets/build_text_field.dart';

class CommunicationController extends GetxController {
  late List<String> listVideo;
  final itemController = TextEditingController();
  //Чи були внесені зміни в дані і НЕ збережені, для перевірки при виході
  bool isChangeData = false;

  @override
  void onInit() {
    listVideo = SP.listVideo;
    super.onInit();
  }

  /// Перевірка, при поверненні назад, чи було збережено
  void backScreen(BuildContext context) async {
    if (!isChangeData) {
      Get.back();
      return;
    }
    showDialog(
      context: context,
      builder: (_) => DialogBack(
        onCancel: () {
          Get.back();
          Get.back(closeOverlays: true);
        },
        onConfirm: () {
          save();
          Get.back();
          Get.back(closeOverlays: true);
          Utils.showSnackBarCheck(context, 'Saved successfully'.tr);
        },
      ),
    );
  }

  void deleteItem(int i) {
    if (listVideo.length == 1) {
      Utils.messageError('Не можна видалити. Залиште один запис'.tr);
      return;
    }
    Get.defaultDialog(
      title: 'Delete'.tr,
      titleStyle: const TextStyle(
        color: DEL_FON_COLOR,
        fontWeight: FontWeight.bold,
      ),
      middleText: '${'DeleleRecord?'.tr}\n\n${listVideo[i]}',
      textCancel: 'Cancel'.tr,
      cancelTextColor: BTT_COLOR,
      textConfirm: 'Ok',
      confirmTextColor: Colors.white,
      buttonColor: BTT_COLOR,
      onConfirm: () {
        listVideo.removeAt(i);
        isChangeData = true;
        Get.back();
        update();
      },
    );
  }

  void editItem(int i) {
    itemController.text = listVideo[i];
    Get.defaultDialog(
      content: BuildTextField(
        autofocus: true,
        prefixIcon: Icons.cast_for_education,
        controller: itemController,
      ),
      title: 'Editing'.tr,
      titleStyle: const TextStyle(
        color: DEL_FON_COLOR,
        fontWeight: FontWeight.bold,
      ),
      textCancel: 'Cancel'.tr,
      cancelTextColor: BTT_COLOR,
      textConfirm: 'Ok',
      confirmTextColor: Colors.white,
      buttonColor: BTT_COLOR,
      onConfirm: () {
        listVideo[i] = itemController.text;
        listVideo.sort((a, b) => a.toUpperCase().compareTo(b.toUpperCase()));
        isChangeData = true;
        Get.back();
        update();
      },
    );
  }

  void addItem() {
    itemController.text = '';
    Get.defaultDialog(
      content: BuildTextField(
        autofocus: true,
        prefixIcon: Icons.cast_for_education,
        controller: itemController,
      ),
      title: 'Adding'.tr,
      titleStyle: const TextStyle(
        color: DEL_FON_COLOR,
        fontWeight: FontWeight.bold,
      ),
      textCancel: 'Cancel'.tr,
      cancelTextColor: BTT_COLOR,
      textConfirm: 'Ok',
      confirmTextColor: Colors.white,
      buttonColor: BTT_COLOR,
      onConfirm: () {
        listVideo.add(itemController.text);
        listVideo.sort((a, b) => a.toUpperCase().compareTo(b.toUpperCase()));
        isChangeData = true;
        Get.back();
        update();
      },
    );
  }

  void save() {
    SP.listVideo = List.from(listVideo);
    isChangeData = false;
  }
}

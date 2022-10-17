import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/sp.dart';
import 'package:tutoring_budget/utils.dart';
import 'package:tutoring_budget/widgets/BuildTextField.dart';

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

  /// Запобігання (перехват) виходу на попередній екран.
  useWillPopScope() => isChangeData
      ? () async {
          backScreen();
          return false;
        }
      : null;

  /// Перевірка, при поверненні назад, чи було збережено
  backScreen() {
    if (isChangeData) {
      Get.defaultDialog(
        title: 'Save'.tr,
        middleText: 'SaveExit'.tr,
        textCancel: 'Do not save'.tr,
        cancelTextColor: BTT_COLOR,
        textConfirm: 'Save'.tr,
        confirmTextColor: Colors.white,
        buttonColor: BTT_COLOR,
        onCancel: () => Get.back(),
        onConfirm: () {
          save();
          Get.back(closeOverlays: true);
          Utils.snackbarCheck('Saved successfully'.tr);
        },
      );
    } else {
      Get.back();
    }
  }

  deleteItem(int i) {
    if (listVideo.length == 1) {
      Utils.messageError('Не можна видалити. Залиште один запис'.tr);
      return;
    } 
    Get.defaultDialog(
      title: 'Delete'.tr,
      titleStyle:
          const TextStyle(color: DEL_FON_COLOR, fontWeight: FontWeight.bold),
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

  editItem(int i) {
    itemController.text = listVideo[i];
    Get.defaultDialog(
      content: BuildTextField(
        autofocus: true,
        prefixIcon: Icons.cast_for_education,
        controller: itemController,
      ),
      title: 'Editing'.tr,
      titleStyle:
          const TextStyle(color: DEL_FON_COLOR, fontWeight: FontWeight.bold),
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

  addItem() {
    itemController.text = '';
    Get.defaultDialog(
      content: BuildTextField(
        autofocus: true,
        prefixIcon: Icons.cast_for_education,
        controller: itemController,
      ),
      title: 'Adding'.tr,
      titleStyle:
          const TextStyle(color: DEL_FON_COLOR, fontWeight: FontWeight.bold),
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

  save() {
    SP.listVideo = List.from(listVideo);
    Get.back();
    Utils.snackbarCheck('Saved successfully'.tr);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants/constants.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/finances_model.dart';
import 'package:tutoring_budget/routes/app_routes.dart';

class FinanceController extends GetxController {
  /// Список проплат
  List<FinanceModel> listFinance = <FinanceModel>[].obs;

  @override
  onInit() async {
    await getListFinance();
    super.onInit();
  }

  /// Отримання списку модельок проплат
  Future getListFinance() async {
    final response = await DB.query(FinanceModel.nameTable);
    if (response == null) return;
    listFinance = response.map((e) => FinanceModel.fromMap(e)).toList();
    // listFinance.sort((a, b) => -a.firstName.compareTo(b.firstName));
    update();
  }

  /// Перехід до AddFinanceScreen
  gotoAddFinance() {
    Get.toNamed(AppRoutes.ADD_FINANCE)
        ?.then((_) async => await getListFinance());
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
      cancelTextColor: MAIN_COLOR,
      textConfirm: 'Ok',
      confirmTextColor: Colors.white,
      buttonColor: MAIN_COLOR,
      onConfirm: () async {
        await DB.deleteFromId(FinanceModel.nameTable, financeId);
        listFinance.removeAt(index);
        Get.back();
        update();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants/constants.dart';
import 'package:tutoring_budget/screen/finance/finance_controller.dart';

class FinanceScreen extends StatelessWidget {
  FinanceScreen({Key? key}) : super(key: key);
  final FinanceController ctrl = Get.put(FinanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FinanceController>(
        builder: (_) => Column(),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: BTT_COLOR,
        elevation: 10,
        onPressed: () {}, //=> ctrl.gotoAddLesson(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants/constants.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/utils.dart';
import 'package:tutoring_budget/widgets/Btt.dart';
import 'package:tutoring_budget/widgets/BuildTextField.dart';

import 'add_finance_controller.dart';

class AddFinanceScreen extends StatelessWidget {
  AddFinanceScreen({ Key? key }) : super(key: key);

  final border = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(color: MAIN_COLOR, width: 1),
  );

  final outlinedBttStyle = OutlinedButton.styleFrom(
    alignment: Alignment.centerLeft,
    side: const BorderSide(color: MAIN_COLOR),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    padding: const EdgeInsets.all(15),
    backgroundColor: const Color.fromRGBO(216, 216, 216, 0.25),
  );

  final styleTextDT = const TextStyle(
      color: MAIN_COLOR, fontSize: 16, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('AddFinanceScreen'.tr,
              maxLines: 2, textAlign: TextAlign.center),
          actions: [Utils.changeLocateBtt()],
        ),
        body: GetBuilder<AddFinanceController>(
          builder: (ctrl) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    _buildListStudent(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: BuildTextField(
                            labelText: 'Сума оплати'.tr,
                            keyboardType: TextInputType.number,
                            controller: ctrl.sumNameController,
                            prefixIcon: Icons.monetization_on_outlined,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: _buildDate(context)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SafeArea(
                      child: Btt(
                        title: 'Save'.tr,
                        onPress: () => ctrl.onSavesss(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //# =================================
  /// Список із студентами
  Widget _buildListStudent() {
    final ctrl = Get.find<AddFinanceController>();
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(216, 216, 216, 0.25),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: ctrl.selectStudent == null ? null : 'Student'.tr,
          hintText: 'Виберіть учня із списку'.tr,
          hintStyle: const TextStyle(color: Colors.grey),
          floatingLabelStyle: const TextStyle(color: BTT_COLOR),
          prefixIcon: const Icon(Icons.school, color: MAIN_COLOR),
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          errorBorder: border,
          disabledBorder: border,
          contentPadding: const EdgeInsets.fromLTRB(0, 20, 5, 15),
        ),
        items: Get.find<StudentController>()
            .listStudent
            .map((e) => DropdownMenuItem(
                child: Text(
                  '${e.firstName} ${e.lastName}${e.adress.isEmpty ? '' : '\n' + e.adress}',
                  maxLines: 2,
                ),
                value: e))
            .toList(),
        onChanged: (e) => ctrl.onChangeStudent(e as StudentModel),
        value: ctrl.selectStudent,
      ),
    );
  }

  /// Кнопка вибору ДАТИ
  Widget _buildDate(BuildContext context) {
    final ctrl = Get.find<AddFinanceController>();
    return OutlinedButton.icon(
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: ctrl.selDate.value,
          firstDate: DateTime(2021),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          ctrl.selDate.value = picked;
        }
      },
      icon: const Icon(Icons.event_note, color: MAIN_COLOR),
      label: Obx(
          () => Text(Utils.getDate(ctrl.selDate.value), style: styleTextDT)),
      style: outlinedBttStyle,
    );
  }
}
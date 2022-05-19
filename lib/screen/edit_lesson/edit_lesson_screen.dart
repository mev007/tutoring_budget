import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/utils.dart';
import 'package:tutoring_budget/widgets/Btt.dart';
import 'package:tutoring_budget/widgets/BuildTextField.dart';

import 'edit_lesson_controller.dart';

class EditLessonScreen extends StatelessWidget {
  const EditLessonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit schedule'.tr, maxLines: 2),
          actions: [Utils.changeLocateBtt()],
        ),
        body: GetBuilder<EditLessonController>(
          builder: (ctrl) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildListStudent(),
                    const SizedBox(height: 10),
                    BuildTextField(
                      labelText: 'Вартість послуги'.tr,
                      keyboardType: TextInputType.number,
                      controller: ctrl.costNameController,
                      prefixIcon: Icons.monetization_on_outlined,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildDate(context)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildTime(context)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SafeArea(
                      child: Column(
                        children: [
                          Btt(
                            title: 'Refresh'.tr,
                            onPress: ctrl.onSave,
                          ),
                        ],
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
    final ctrl = Get.find<EditLessonController>();
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
          border: BORDER_DROPDOWN,
          focusedBorder: BORDER_DROPDOWN,
          enabledBorder: BORDER_DROPDOWN,
          errorBorder: BORDER_DROPDOWN,
          disabledBorder: BORDER_DROPDOWN,
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
    final ctrl = Get.find<EditLessonController>();
    return OutlinedButton.icon(
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        final DateTime? picked = await showDatePicker(
          context: context,
          // locale: const Locale('uk', 'UA'),
          initialDate: ctrl.selDate.value,
          firstDate: DateTime(2021),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          ctrl.selDate.value = picked;
        }
      },
      icon: const Icon(Icons.event_note, color: MAIN_COLOR),
      label:
          Obx(() => Text(Utils.getDate(ctrl.selDate.value), style: STYLE_DATE)),
      style: OUTLINED_BTT_STYLE,
    );
  }

  /// Кнопка вибору ЧАСУ
  Widget _buildTime(BuildContext context) {
    final ctrl = Get.find<EditLessonController>();
    return OutlinedButton.icon(
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        final picked = await showTimePicker(
          context: context,
          initialTime: ctrl.selTime.value,
        );
        if (picked != null) ctrl.selTime.value = picked;
      },
      icon: const Icon(Icons.watch_later_outlined, color: MAIN_COLOR),
      label: Obx(() =>
          Text(Utils.getTimeString(ctrl.selTime.value), style: STYLE_DATE)),
      style: OUTLINED_BTT_STYLE,
    );
  }
}

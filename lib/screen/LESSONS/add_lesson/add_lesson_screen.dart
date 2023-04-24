import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/utils.dart';
import 'package:tutoring_budget/widgets/Btt.dart';
import 'package:tutoring_budget/widgets/BuildTextField.dart';
import 'package:tutoring_budget/widgets/custom_appbar.dart';
import 'package:tutoring_budget/widgets/my_icon.dart';

import 'add_lesson_controller.dart';

class AddLessonScreen extends StatelessWidget {
  const AddLessonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Add a schedule'.tr),
        body: GetBuilder<AddLessonController>(
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
                    Obx(() => _buildRepeatLesson(context)),
                    const SizedBox(height: 10),
                    SafeArea(
                      child: Column(
                        children: [
                          Btt(
                            title: 'Save'.tr,
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
    final ctrl = Get.find<AddLessonController>();

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
          hintStyle: const TextStyle(color: GREY_COLOR),
          floatingLabelStyle: const TextStyle(color: BTT_COLOR),
          prefixIcon: const MyIcon(Icons.school),
          border: BORDER_DROPDOWN,
          focusedBorder: BORDER_DROPDOWN,
          enabledBorder: BORDER_DROPDOWN,
          errorBorder: BORDER_DROPDOWN,
          disabledBorder: BORDER_DROPDOWN,
          contentPadding: const EdgeInsets.fromLTRB(0, 20, 5, 15),
        ),
        items: Get.find<StudentController>()
            .listStudent
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  '${e.firstName} ${e.lastName}${e.adress.isEmpty ? '' : '\n${e.adress}'}',
                  maxLines: 2,
                ),
              ),
            )
            .toList(),
        onChanged: (e) => ctrl.onChangeStudent(e as StudentModel),
        value: ctrl.selectStudent,
      ),
    );
  }

  /// Кнопка вибору ДАТИ
  Widget _buildDate(BuildContext context) {
    final ctrl = Get.find<AddLessonController>();
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
          ctrl.definitionNameDayUKR();
        }
      },
      icon: const MyIcon(Icons.event_note),
      label:
          Obx(() => Text(Utils.getDate(ctrl.selDate.value), style: STYLE_DATE)),
      style: OUTLINED_BTT_STYLE,
    );
  }

  /// Кнопка вибору ЧАСУ
  Widget _buildTime(BuildContext context) {
    final ctrl = Get.find<AddLessonController>();
    return OutlinedButton.icon(
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        final picked = await showTimePicker(
          context: context,
          initialTime: ctrl.selTime.value,
        );
        if (picked != null) ctrl.selTime.value = picked;
      },
      icon: const MyIcon(Icons.watch_later_outlined),
      label: Obx(() =>
          Text(Utils.getTimeString(ctrl.selTime.value), style: STYLE_DATE)),
      style: OUTLINED_BTT_STYLE,
    );
  }

  /// Налаштування повтору занять
  Widget _buildRepeatLesson(BuildContext context) {
    final ctrl = Get.find<AddLessonController>();
    final outlinedBttStyle = OutlinedButton.styleFrom(
      alignment: Alignment.centerLeft,
      side: const BorderSide(color: MAIN_COLOR),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      backgroundColor: const Color.fromRGBO(216, 216, 216, 0.25),
    );
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: ctrl.isCheckbox.value,
              activeColor: BTT_COLOR,
              onChanged: (val) {
                FocusManager.instance.primaryFocus?.unfocus();
                ctrl.isCheckbox.value = !ctrl.isCheckbox.value;
              },
            ),
            Expanded(child: Text('Використовувати повторюваність занять'.tr)),
          ],
        ),
        Visibility(
          visible: ctrl.isCheckbox.value,
          child: Column(
            children: [
              Text('Буде встановлено повторення занять'.tr),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('в кожен день'.tr),
                  Obx(() => Text(' ${ctrl.nameDay.value.tr} ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
                  Text('в заданий період'.tr),
                ],
              ),
              const SizedBox(height: 10),
              Text('Встановіть період повторень'.tr),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('з'.tr),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: ctrl.fromDateTime.value,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );
                      if (picked != null) ctrl.fromDateTime.value = picked;
                    },
                    style: outlinedBttStyle,
                    child: Obx(() => Text(
                        Utils.getDate(ctrl.fromDateTime.value),
                        style: STYLE_DATE)),
                  ),
                  const SizedBox(width: 20),
                  Text('по'.tr),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: ctrl.toDateTime.value,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );
                      if (picked != null) ctrl.toDateTime.value = picked;
                    },
                    style: outlinedBttStyle,
                    child: Obx(() => Text(Utils.getDate(ctrl.toDateTime.value),
                        style: STYLE_DATE)),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

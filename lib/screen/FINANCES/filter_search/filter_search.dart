import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/sp.dart';
import 'package:tutoring_budget/utils.dart';
import 'package:tutoring_budget/widgets/Btt.dart';

import 'filter_search_controller.dart';

class FillterSearch extends StatelessWidget {
  const FillterSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FillterSearchController>(
      builder: (ctrl) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Задайте параметри фільтрування'.tr, maxLines: 2),
                const SizedBox(height: 15),
                _buildListStudent(),
                const SizedBox(height: 10),
                _buildCategory(),
                const SizedBox(height: 10),
                _buildVideo(),
                const SizedBox(height: 20),
                Text('Задайте період'.tr),
                const SizedBox(height: 10),
                _buildFromDate(context),
                const SizedBox(height: 10),
                _buildToDate(context),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Btt(
              onPress: () => Get.back(),
              title: 'Cancel'.tr,
              isNegative: true,
            ),
            Btt(
              onPress: () => ctrl.onApply(),
              title: 'Застосувати'.tr,
            )
          ],
        );
      },
    );
  }

  //# =================================
  /// Список із студентами
  Widget _buildListStudent() {
    final ctrl = Get.find<FillterSearchController>();
    return Container(
      height: 54,
      // width: 250,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(216, 216, 216, 0.25),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonFormField(
        isDense: false,
        isExpanded: true,
        hint: Text('Виберіть учня для фільтрування'.tr, style: const TextStyle(color: GREY_COLOR)),
        decoration: InputDecoration(
          labelText: ctrl.selectStudent == null ? null : 'Student'.tr,
          // hintText: 'Виберіть учня для фільтрування'.tr,
          // hintMaxLines: 2,
          // hintStyle: const TextStyle(color: GREY_COLOR),
          floatingLabelStyle: const TextStyle(color: BTT_COLOR),
          prefixIcon: const Icon(Icons.school, color: MAIN_COLOR),
          suffixIcon: IconButton(
              onPressed: () => ctrl.onClearStudent(),
              iconSize: 20,
              splashRadius: 20,
              icon: const Icon(Icons.close, color: DEL_FON_COLOR)),
          border: BORDER_DROPDOWN,
          focusedBorder: BORDER_DROPDOWN,
          enabledBorder: BORDER_DROPDOWN,
          errorBorder: BORDER_DROPDOWN,
          disabledBorder: BORDER_DROPDOWN,
          contentPadding: const EdgeInsets.fromLTRB(0, 3, 0, 2),
        ),
        items: Get.find<StudentController>()
            .listStudent
            .map((e) => DropdownMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${e.firstName} ${e.lastName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      e.adress.isEmpty ? '' : e.adress,
                      style: const TextStyle(fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                value: e))
            .toList(),
        onChanged: (e) => ctrl.onChangeStudent(e as StudentModel),
        value: ctrl.selectStudent,
      ),
    );
  }

  /// Список із категоріями
  Widget _buildCategory() {
    final ctrl = Get.find<FillterSearchController>();
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(216, 216, 216, 0.25),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonFormField(
        isDense: false,
        isExpanded: true,
        hint: Text('Категорія навчання'.tr,
            style: const TextStyle(color: GREY_COLOR)),
        decoration: InputDecoration(
          labelText:
              ctrl.selectCategory == null ? null : 'Категорія навчання'.tr,
          // hintText: 'Категорія навчання'.tr,
          // hintStyle: const TextStyle(color: GREY_COLOR),
          floatingLabelStyle: const TextStyle(color: BTT_COLOR),
          prefixIcon: const Icon(Icons.cast_for_education, color: MAIN_COLOR),
          suffixIcon: IconButton(
              onPressed: () => ctrl.onClearCategory(),
              iconSize: 20,
              splashRadius: 20,
              icon: const Icon(Icons.close, color: DEL_FON_COLOR)),
          border: BORDER_DROPDOWN,
          focusedBorder: BORDER_DROPDOWN,
          enabledBorder: BORDER_DROPDOWN,
          errorBorder: BORDER_DROPDOWN,
          disabledBorder: BORDER_DROPDOWN,
          contentPadding: const EdgeInsets.fromLTRB(0, 3, 0, 2),
        ),
        items: SP.listCategory
            .map((e) => DropdownMenuItem(child: Text(e, maxLines: 2), value: e))
            .toList(),
        onChanged: (e) => ctrl.onChangeCategory(e.toString()),
        value: ctrl.selectCategory,
      ),
    );
  }

  /// Вибір месенджера
  Widget _buildVideo() {
    final ctrl = Get.find<FillterSearchController>();
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(216, 216, 216, 0.25),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonFormField(
        isDense: false,
        isExpanded: true,
        hint: Text('Месенджер'.tr, style: const TextStyle(color: GREY_COLOR)),
        decoration: InputDecoration(
          labelText:
              ctrl.selectVideo == null ? null : 'Програма спілкування'.tr,
          floatingLabelStyle: const TextStyle(color: BTT_COLOR),
          prefixIcon: const Icon(Icons.personal_video, color: MAIN_COLOR),
          suffixIcon: IconButton(
              onPressed: () => ctrl.onClearVideo(),
              iconSize: 20,
              splashRadius: 20,
              icon: const Icon(Icons.close, color: DEL_FON_COLOR)),
          border: BORDER_DROPDOWN,
          focusedBorder: BORDER_DROPDOWN,
          enabledBorder: BORDER_DROPDOWN,
          errorBorder: BORDER_DROPDOWN,
          disabledBorder: BORDER_DROPDOWN,
          contentPadding: const EdgeInsets.fromLTRB(0, 3, 0, 2),
        ),
        items: SP.listVideo
            .map((e) => DropdownMenuItem(child: Text(e, maxLines: 1), value: e))
            .toList(),
        onChanged: (e) => ctrl.onChangeVideo(e.toString()),
        value: ctrl.selectVideo,
      ),
    );
  }

  /// Вибір дати "З"
  _buildFromDate(BuildContext context) {
    final ctrl = Get.find<FillterSearchController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('з'.tr),
        const SizedBox(width: 10),
        SizedBox(
          width: 170,
          child: OutlinedButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: ctrl.selectFromDateTime ?? DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime(DateTime.now().year + 5),
              );
              ctrl.onChangeFromDate(picked);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    ctrl.selectFromDateTime == null
                        ? 'Виберіть дату'.tr
                        : Utils.getDate(ctrl.selectFromDateTime),
                    style: ctrl.selectFromDateTime == null
                        ? STYLE_DATE.copyWith(color: GREY_COLOR)
                        : STYLE_DATE,
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () => ctrl.onClearFromDate(),
                  iconSize: 20,
                  splashRadius: 20,
                  icon: const Icon(Icons.close, color: DEL_FON_COLOR),
                  constraints: const BoxConstraints(maxHeight: 36),
                )
              ],
            ),
            style: OUTLINED_DT,
          ),
        ),
      ],
    );
  }

  /// Вибір дати "ПО"
  _buildToDate(BuildContext context) {
    final ctrl = Get.find<FillterSearchController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('по'.tr),
        const SizedBox(width: 10),
        SizedBox(
          width: 170,
          child: OutlinedButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: ctrl.selectToDateTime ?? DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime(DateTime.now().year + 5),
              );
              ctrl.onChangeToDate(picked);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    ctrl.selectToDateTime == null
                        ? 'Виберіть дату'.tr
                        : Utils.getDate(ctrl.selectToDateTime),
                    style: ctrl.selectToDateTime == null
                        ? STYLE_DATE.copyWith(color: GREY_COLOR)
                        : STYLE_DATE,
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () => ctrl.onClearToDate(),
                  iconSize: 20,
                  splashRadius: 20,
                  icon: const Icon(Icons.close, color: DEL_FON_COLOR),
                  constraints: const BoxConstraints(maxHeight: 36),
                )
              ],
            ),
            style: OUTLINED_DT,
          ),
        ),
      ],
    );
  }
}

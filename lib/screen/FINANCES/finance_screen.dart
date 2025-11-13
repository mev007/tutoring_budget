import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/models/finances_model.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/utils.dart';

import 'filter_search/filter_search.dart';
import 'finance_controll.dart';

class FinanceScreen extends StatelessWidget {
  FinanceScreen({super.key});
  final FinanceController ctrl = Get.put(FinanceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FinanceController>(
        builder: (_) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                children: [
                  Expanded(child: _buildTitleParamFilter()),
                  _buildBoardFilter(context),
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // _BtnSort(),
                        _BtnFilter(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: ctrl.listFinance.length + 1,
                separatorBuilder: (_, _) => const Divider(
                  color: MAIN_COLOR,
                  height: 1,
                ),
                itemBuilder: (_, i) {
                  //Добавлення відсупу знизу
                  if (i == ctrl.listFinance.length) {
                    return const SizedBox(height: 100);
                  }
                  final item = ctrl.listFinance[i];
                  return _buildItem(i, item);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => ctrl.gotoAddFinance(),
      ),
    );
  }

  //#  ===============   ДОДАТКОВІ МЕТОДИ   =================
  /// інформація про параметри фільтру
  Column _buildTitleParamFilter() {
    return Column(
      children: [
        ctrl.titleStudent.isEmpty
            ? const SizedBox.square()
            : AutoSizeText(
                ctrl.titleStudent,
                textAlign: TextAlign.center,
                minFontSize: 6,
                maxLines: 1,
              ),
        ctrl.titleCategor.isEmpty
            ? const SizedBox.square()
            : AutoSizeText(
                ctrl.titleCategor,
                textAlign: TextAlign.center,
                minFontSize: 6,
                maxLines: 1,
              ),
        ctrl.titleVideo.isEmpty
            ? const SizedBox.square()
            : AutoSizeText(
                ctrl.titleVideo,
                textAlign: TextAlign.center,
                minFontSize: 6,
                maxLines: 1,
              ),
        ctrl.titleDate.isEmpty
            ? const SizedBox.square()
            : AutoSizeText(
                ctrl.titleDate,
                textAlign: TextAlign.center,
                minFontSize: 6,
                maxLines: 1,
              ),
      ],
    );
  }

  /// Дошка для СУМИ фільтрування
  Widget _buildBoardFilter(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: MAIN_COLOR, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            AutoSizeText('Сума платежів'.tr, maxLines: 1, minFontSize: 6),
            Text(ctrl.sum.toStringAsFixed(0),
                style: STYLE_PARAM.copyWith(fontSize: 24)),
          ],
        ),
      ),
    );
  }

  /// Елемент списка СТУДЕНТІВ
  Widget _buildItem(int i, FinanceModel item) {
    final itemStudent = Get.find<StudentController>().listStudent.firstWhere(
      (st) => st.id == item.idStudent,
      orElse: () {
        log('>>> Error: No search STUDENT ${item.idStudent}');
        return StudentModel(
            firstName: '!!! Інформація відсутня !!!',
            adress: 'Запис про учня був видалений');
      },
    );

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => ctrl.deleteStudent(i),
            backgroundColor: DEL_FON_COLOR,
            foregroundColor: WHITE_COLOR,
            icon: Icons.delete,
          ),
        ],
      ),
      child: InkWell(
        // onTap: () => ctrl.gotoDetailStudent(item),
        splashColor: MAIN_COLOR.withAlpha(25),
        child: SizedBox(
          height: 70,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: CircleAvatar(
              backgroundColor: ICON_COLOR,
              foregroundColor: Colors.white,
              child: Text(item.sum.toStringAsFixed(0),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: AutoSizeText(
                '${itemStudent.firstName} ${itemStudent.lastName}',
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: AutoSizeText(itemStudent.category,
                minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Text(Utils.getDate(item.dateTime),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}

// class _BtnSort extends GetView<FinanceController> {
//   /// Кнопка для сортування
//   const _BtnSort();
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: SizedBox(
//         height: 40,
//         width: 40,
//         child: FloatingActionButton(
//           heroTag: null,
//           tooltip: 'Сортування для фінансів'.tr,
//           backgroundColor: BTT_COLOR,
//           child: const Icon(Iconsax.sort, color: Colors.white),
//           onPressed: () {
//             if (Get.find<StudentController>().listStudent.isEmpty) {
//               Utils.messageErrorAddStudent();
//             } else {
//               showDialog(
//                 context: context,
//                 builder: (context) => const FillterSearch(),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

class _BtnFilter extends GetView<FinanceController> {
  /// Кнопка для фільтру
  const _BtnFilter();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 40,
        width: 40,
        child: FloatingActionButton(
          heroTag: null,
          tooltip: 'Фільтр для фінансів'.tr,
          backgroundColor: BTT_COLOR,
          child: GetBuilder<FinanceController>(
            builder: (_) => Icon(
              controller.isEmptyParamInfo()
                  ? Icons.filter_alt_off_outlined
                  : Icons.filter_alt_outlined,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            if (Get.find<StudentController>().listStudent.isEmpty) {
              Utils.messageErrorAddStudent();
            } else {
              showDialog(
                context: context,
                builder: (context) => const FillterSearch(),
              );
            }
          },
        ),
      ),
    );
  }
}

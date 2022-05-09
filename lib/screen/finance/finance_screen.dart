import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants/constants.dart';
import 'package:tutoring_budget/models/finances_model.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/utils.dart';

import 'finance_controll.dart';

class FinanceScreen extends StatelessWidget {
  FinanceScreen({Key? key}) : super(key: key);
  final FinanceController ctrl = Get.put(FinanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<FinanceController>(
        builder: (_) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: ctrl.listFinance.length + 1,
          separatorBuilder: (_, __) => const Divider(
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
      floatingActionButton: FloatingActionButton(
          heroTag: null,
          child: const Icon(Icons.add, color: Colors.white),
          backgroundColor: BTT_COLOR,
          elevation: 10,
          onPressed: () => ctrl.gotoAddFinance(),
          ),
    );
  }

  //#  ===============   ДОДАТКОВІ МЕТОДИ   =================
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
      actionPane: const SlidableStrechActionPane(),
      actionExtentRatio: 0.25,
      actions: [
        IconSlideAction(
            color: EDIT_FON_COLOR,
            foregroundColor: SLIDE_ICON_COLOR,
            icon: Icons.edit,
            onTap: () => {} //ctrl.gotoEditStudent(item),
            ),
      ],
      secondaryActions: [
        IconSlideAction(
            color: DEL_FON_COLOR,
            foregroundColor: SLIDE_ICON_COLOR,
            icon: Icons.delete,
            onTap: () => ctrl.deleteStudent(i),
            ),
      ],
      child: InkWell(
        child: SizedBox(
          height: 90,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: CircleAvatar(
              backgroundColor: ICON_COLOR,
              child: Text(item.sum.toStringAsFixed(0),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              foregroundColor: Colors.white,
            ),
            minVerticalPadding: 10,
            title: AutoSizeText(
              '${itemStudent.firstName} ${itemStudent.lastName}',
              maxLines: 1,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: AutoSizeText(itemStudent.adress,
                minFontSize: 10, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Text(Utils.getDate(item.dateTime),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ),
        onTap: () => {}, //ctrl.gotoDetailStudent(item),
        splashColor: MAIN_COLOR.withOpacity(0.1),
      ),
      // ),
    );
  }
}
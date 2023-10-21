import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/utils.dart';

import '../lessons_controller.dart';

class ItemLesson extends StatelessWidget {
  const ItemLesson({super.key, required this.i});
  final int i;

  @override
  Widget build(BuildContext context) {
    final ctrlLesson = Get.find<LessonsController>();
    final item = ctrlLesson.listLessons[i];
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
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => ctrlLesson.gotoEditLesson(item),
            backgroundColor: EDIT_FON_COLOR,
            foregroundColor: WHITE_COLOR,
            icon: Icons.edit,
            // label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.5,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => ctrlLesson.deleteLesson(i),
            backgroundColor: DEL_FON_COLOR,
            foregroundColor: WHITE_COLOR,
            icon: Icons.delete,
          ),
          SlidableAction(
            onPressed: (_) => ctrlLesson.deleteAllFromDate(
                i, '${itemStudent.firstName} ${itemStudent.lastName}'),
            backgroundColor: BTT_COLOR,
            foregroundColor: WHITE_COLOR,
            icon: Icons.auto_delete,
          ),
        ],
      ),
      child: InkWell(
        // onTap: () => ctrl.gotoTeacherTestDetail(item),
        splashColor: MAIN_COLOR.withOpacity(0.1),
        child: SizedBox(
          height: 90,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: CircleAvatar(
              backgroundColor: item.balance < 0 ? DEL_FON_COLOR : GREEN_COLOR,
              foregroundColor: Colors.white,
              radius: 25,
              child: Text(Utils.getTime(item.dateTime),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            minVerticalPadding: 10,
            title: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: AutoSizeText(
                      '${itemStudent.firstName} ${itemStudent.lastName}',
                      maxLines: 1,
                      minFontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                AutoSizeText(
                  item.cost.toStringAsFixed(2),
                  maxLines: 1,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AutoSizeText(itemStudent.adress,
                    minFontSize: 10,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(itemStudent.category,
                        minFontSize: 10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    AutoSizeText(itemStudent.video,
                        minFontSize: 10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                AutoSizeText(itemStudent.note,
                    minFontSize: 12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}

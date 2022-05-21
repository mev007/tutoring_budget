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
  const ItemLesson({Key? key, required this.i}) : super(key: key);
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
      actionPane: const SlidableStrechActionPane(),
      actionExtentRatio: 0.25,
      actions: [
        IconSlideAction(
          color: EDIT_FON_COLOR,
          foregroundColor: SLIDE_ICON_COLOR,
          icon: Icons.edit,
          onTap: () => ctrlLesson.gotoEditLesson(item),
        ),
      ],
      secondaryActions: [
        IconSlideAction(
          color: DEL_FON_COLOR,
          foregroundColor: SLIDE_ICON_COLOR,
          icon: Icons.delete,
          onTap: () => ctrlLesson.deleteLesson(i),
        ),
        IconSlideAction(
          color: BTT_COLOR,
          foregroundColor: SLIDE_ICON_COLOR,
          icon: Icons.auto_delete,
          onTap: () => ctrlLesson.deleteAllFromDate(
              i, '${itemStudent.firstName} ${itemStudent.lastName}'),
        ),
      ],

      //
      child: InkWell(
        child: SizedBox(
          height: 90,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: CircleAvatar(
              backgroundColor: item.balance < 0 ? DEL_FON_COLOR : GREEN_COLOR,
              child: Text(Utils.getTime(item.dateTime),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              foregroundColor: Colors.white,
              radius: 25,
            ),
            minVerticalPadding: 10,
            title: Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    '${itemStudent.firstName} ${itemStudent.lastName}',
                    maxLines: 1,
                    minFontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AutoSizeText(
                  item.cost.toStringAsFixed(2) + '₴',
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
        onTap: () {}, //=> ctrl.gotoTeacherTestDetail(item),
        splashColor: MAIN_COLOR.withOpacity(0.1),
      ),
      // ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/models/student_model.dart';

import 'student_controll.dart';

class StudentScreen extends StatelessWidget {
  StudentScreen({super.key});
  final StudentController ctrl = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StudentController>(
        builder: (_) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: ctrl.listStudent.length + 1,
          separatorBuilder: (_, __) => const Divider(
            color: MAIN_COLOR,
            height: 1,
          ),
          itemBuilder: (_, i) {
            //Добавлення відсупу знизу
            if (i == ctrl.listStudent.length) {
              return const SizedBox(height: 100);
            }
            final item = ctrl.listStudent[i];
            return _buildItem(i, item);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => ctrl.gotoAddStudent(),
      ),
    );
  }

  //#  ===============   ДОДАТКОВІ МЕТОДИ   =================
  /// Елемент списка СТУДЕНТІВ
  Widget _buildItem(int i, StudentModel item) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => ctrl.gotoEditStudent(item),
            backgroundColor: EDIT_FON_COLOR,
            foregroundColor: WHITE_COLOR,
            icon: Icons.edit,
            // label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const StretchMotion(),
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
        onTap: () => ctrl.gotoDetailStudent(item),
        splashColor: MAIN_COLOR.withOpacity(0.1),
        child: SizedBox(
          height: 100,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: CircleAvatar(
              backgroundColor: ICON_COLOR,
              foregroundColor: Colors.white,
              child: Text(item.cost.toStringAsFixed(0),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            minVerticalPadding: 10,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: AutoSizeText(
                '${item.firstName} ${item.lastName}',
                maxLines: 1,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AutoSizeText(item.adress,
                    minFontSize: 10,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(item.category,
                        minFontSize: 10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    AutoSizeText(item.video,
                        minFontSize: 10,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                AutoSizeText(item.note,
                    minFontSize: 12,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            // trailing: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     SizedBox(
            //       width: 50,
            //       child: Row(children: [
            //         const Icon(Icons.timer, color: MAIN_COLOR, size: 20),
            //         Text(item.time.toStringAsFixed(1))
            //       ]),
            //     ),
            //     Icon(item.isRnd ? Icons.shuffle : Icons.double_arrow_rounded,
            //         color: MAIN_COLOR),
            //   ],
            // ),
          ),
        ),
      ),
      // ),
    );
  }
}

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tutoring_budget/constants/constants.dart';
import 'package:tutoring_budget/models/lessons_model.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/student/student_controll.dart';
import 'package:tutoring_budget/utils.dart';

import 'lessons_controller.dart';

class LessonsScreen extends StatelessWidget {
  LessonsScreen({Key? key}) : super(key: key);
  final LessonsController ctrl = Get.put(LessonsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LessonsController>(
        builder: (_) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 5.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(color: MAIN_COLOR, width: 2.0),
                ),
                child: _buildCalendar(),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ctrl.listLessons.length,
                separatorBuilder: (_, __) =>
                    const Divider(color: MAIN_COLOR, height: 1),
                itemBuilder: (_, i) {
                  //Добавлення відсупу знизу
                  // if (i == ctrl.listLessons.length) {
                  //   return const SizedBox(height: 100);
                  // }
                  return _buildItem(i, ctrl.listLessons[i]);
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: BTT_COLOR,
        elevation: 10,
        onPressed: () => ctrl.gotoAddLesson(),
      ),
    );
  }

  //#  ===============   ДОДАТКОВІ МЕТОДИ   =================
  /// Календар
  Widget _buildCalendar() {
    return TableCalendar(
      //% Налаштування ==========
      focusedDay: ctrl.focusedDay,
      firstDay: ctrl.kFirstDay,
      lastDay: ctrl.kLastDay,
      calendarFormat: ctrl.calendarFormat,
      weekendDays: const [DateTime.saturday, DateTime.sunday],
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekHeight: 30,
      rowHeight: 45,
      pageAnimationCurve: Curves.easeOut,
      locale: '${Get.locale}',
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(color: DEL_FON_COLOR),
      ),
      //% Заголовок ==========
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
        decoration: BoxDecoration(
            color: MAIN_COLOR,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        formatButtonTextStyle: TextStyle(color: MAIN_COLOR, fontSize: 16.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
      ),
      //% Стилі календаря ==========
      calendarStyle: const CalendarStyle(
        weekendTextStyle: TextStyle(color: DEL_FON_COLOR),
        todayDecoration:
            BoxDecoration(color: ADD_COLOR, shape: BoxShape.circle),
        selectedDecoration:
            BoxDecoration(color: MAIN_COLOR, shape: BoxShape.circle),
      ),
      //% Події ==========
      selectedDayPredicate: (day) {
        return (isSameDay(ctrl.selDay, day));
      },
      onDaySelected: (selectedDay, focusedDay) {
        ctrl.onDaySelected(selectedDay, focusedDay);
      },
      onFormatChanged: (format) => ctrl.onFormatChanged(format),
    );
  }

  /// Елемент списка ЗАНЯТЬ студентів
  Widget _buildItem(int i, LessonsModel item) {
    final ddd = ctrl.listLessons;
    final sss = Get.find<StudentController>().listStudent;
    final itemStudent = Get.find<StudentController>().listStudent.firstWhere(
      (st) => st.id == item.idStudent,
      orElse: () {
        log('>>> Error: No search STUDENT ${item.idStudent}');
        return StudentModel(firstName: '⚠️⁉️ Інформація відсутня ⁉️⚠️', adress: 'Запис про учня був видалений');
      },
    );

    return Slidable(
      actionPane: const SlidableStrechActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: [
        IconSlideAction(
          color: DEL_FON_COLOR,
          foregroundColor: DEL_ICON_COLOR,
          icon: Icons.delete,
          onTap: () => ctrl.deleteLesson(i),
        ),
      ],

      //
      child: InkWell(
        child: SizedBox(
          height: 90,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            leading: CircleAvatar(
              backgroundColor: ADD_COLOR,
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

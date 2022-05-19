import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tutoring_budget/constants.dart';

import 'lessons_controller.dart';
import 'views/item_lesson.dart';

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
                  return ItemLesson(i: i);
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
}



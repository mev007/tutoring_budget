import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/utils.dart';

import 'lessons_controller.dart';
import 'views/item_lesson.dart';

class LessonsScreen extends StatelessWidget {
  LessonsScreen({super.key});
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
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(color: MAIN_COLOR, width: 2.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildCalendar(),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ctrl.listLessons.length,
                separatorBuilder: (_, _) =>
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
        onPressed: () => ctrl.gotoAddLesson(context),
      ),
    );
  }

  //#  ===============   ДОДАТКОВІ МЕТОДИ   =================
  /// Календар
  Widget _buildCalendar() {
    return TableCalendar(
      //% Налаштування ==========
      calendarBuilders: CalendarBuilders(
        markerBuilder: (_, date, _) {
          final count = ctrl.mapMarket[Utils.withoutTime(date)];
          return count == null
              ? const SizedBox.shrink()
              : Positioned(
                  bottom: 5,
                  right: 5,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: BTT_COLOR,
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
        },
      ),
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
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
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
        todayDecoration: BoxDecoration(
          color: ADD_COLOR,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: MAIN_COLOR,
          shape: BoxShape.circle,
        ),
      ),
      //% Події ==========
      selectedDayPredicate: (day) {
        return (isSameDay(ctrl.selDay, day));
      },
      onDaySelected: (selectedDay, focusedDay) {
        ctrl.onDaySelected(selectedDay, focusedDay);
      },
      onFormatChanged: (format) => ctrl.onFormatChanged(format),
      onPageChanged: (date) => ctrl.onPageChanged(date),
    );
  }
}

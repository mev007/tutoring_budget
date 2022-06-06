import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/screen/FINANCES/finance_screen.dart';
import 'package:tutoring_budget/screen/lessons/lessons_screen.dart';
import 'package:tutoring_budget/screen/setting/setting_screen.dart';
import 'package:tutoring_budget/screen/student/student_screen.dart';

import 'board_controller.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoardController>(
      init: BoardController(),
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(title: Text('Tutor budget'.tr, maxLines: 2)),
          body: SafeArea(
            child: IndexedStack(
              index: ctrl.tabIndex,
              children: [
                StudentScreen(),
                LessonsScreen(),
                FinanceScreen(),
                SettingScreen(),
              ],
            ),
          ),
          bottomNavigationBar: _buildNavigationBar(),
        );
      },
    );
  }

  Widget _buildNavigationBar() {
    final BoardController ctrl = Get.find<BoardController>();
    return ConvexAppBar(
      height: 60,
      activeColor: Colors.white,
      backgroundColor: MAIN_COLOR,
      style: TabStyle.reactCircle,
      // cornerRadius: 12,
      initialActiveIndex: ctrl.tabIndex,
      onTap: (index) => ctrl.changeTabIndex(index),
      color: Colors.white,
      items: [
        TabItem(
          icon: Icon(Icons.school, color: _buildColorTab(0, ctrl)),
          title: 'Students'.tr,
        ),
        TabItem(
          icon: Icon(Icons.event_note, color: _buildColorTab(1, ctrl)),
          title: 'Lessons'.tr,
        ),
        TabItem(
          icon: Icon(Icons.savings, color: _buildColorTab(2, ctrl)),
          title: 'Finances'.tr,
        ),
        TabItem(
          icon: Icon(Icons.settings, color: _buildColorTab(3, ctrl)),
          title: 'Setting'.tr,
        ),
      ],
    );
  }

  Color _buildColorTab(int index, BoardController ctrl) =>
      ctrl.tabIndex == index ? MAIN_COLOR : Colors.white;
}

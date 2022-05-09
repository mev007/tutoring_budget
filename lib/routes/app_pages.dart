import 'package:get/get.dart';
import 'package:tutoring_budget/screen/add_finance/add_finance_controller.dart';
import 'package:tutoring_budget/screen/add_finance/add_finance_screen.dart';
import 'package:tutoring_budget/screen/add_lesson/add_lesson_controller.dart';
import 'package:tutoring_budget/screen/add_lesson/add_lesson_screen.dart';
import 'package:tutoring_budget/screen/add_student/add_student_controller.dart';
import 'package:tutoring_budget/screen/add_student/add_student_screen.dart';
import 'package:tutoring_budget/screen/board/board_controller.dart';
import 'package:tutoring_budget/screen/board/board_screen.dart';
import 'package:tutoring_budget/screen/detail_student/detail_student_controller.dart';
import 'package:tutoring_budget/screen/detail_student/detail_student_screen.dart';
import 'package:tutoring_budget/screen/edit_student/edit_student_controller.dart';
import 'package:tutoring_budget/screen/edit_student/edit_student_screen.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
   
    GetPage(
      name: AppRoutes.BOARD,
      page: () => const BoardScreen(),
      binding: BindingsBuilder(
          () => Get.lazyPut<BoardController>(() => BoardController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.ADD_STUDENT,
      page: () => const AddStudentScreen(),
      binding: BindingsBuilder(() =>
          Get.lazyPut<AddStudentController>(() => AddStudentController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.ADD_FINANCE,
      page: () => AddFinanceScreen(),
      binding: BindingsBuilder(() =>
          Get.lazyPut<AddFinanceController>(() => AddFinanceController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.ADD_LESSON,
      page: () => AddLessonScreen(),
      binding: BindingsBuilder(() =>
          Get.lazyPut<AddLessonController>(() => AddLessonController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.EDIT_STUDENT,
      page: () => const EditStudentScreen(),
      binding: BindingsBuilder(() =>
          Get.lazyPut<EditStudentController>(() => EditStudentController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.DETAIL_STUDENT,
      page: () => const DetailStudentScreen(),
      binding: BindingsBuilder(() =>
          Get.lazyPut<DetailStudentController>(() => DetailStudentController())),
      transition: Transition.cupertino,
    ),
    // GetPage(
    //   name: AppRoutes.ABOUT_CARGO,
    //   page: () => const AboutCargoScreen(),
    //   binding: BindingsBuilder(() =>
    //       Get.lazyPut<AboutCargoController>(() => AboutCargoController())),
    //   transition: Transition.cupertino,
    // ),
    // GetPage(
    //   name: AppRoutes.POS,
    //   page: () => const POsScreen(),
    //   binding: BindingsBuilder(
    //       () => Get.lazyPut<POsController>(() => POsController())),
    //   transition: Transition.cupertino,
    // ),
    // GetPage(
    //   name: AppRoutes.ADD_PAGE,
    //   page: () => const AddPageScreen(),
    //   binding: BindingsBuilder(
    //       () => Get.lazyPut<AddPageController>(() => AddPageController())),
    //   transition: Transition.noTransition,
    // ),
    // GetPage(
    //   name: AppRoutes.MY_SALARIES,
    //   page: () => const MySalariesScreen(),
    //   binding: BindingsBuilder(() =>
    //       Get.lazyPut<MySalariesController>(() => MySalariesController())),
    //   transition: Transition.cupertino,
    // ),
    // GetPage(
    //   name: AppRoutes.REPORT_SALARY,
    //   page: () => const ReportSalaryScreen(),
    //   binding: BindingsBuilder(() =>
    //       Get.lazyPut<ReportSalaryController>(() => ReportSalaryController())),
    //   transition: Transition.cupertino,
    // ),
    // GetPage(
    //   name: AppRoutes.SUPPORT,
    //   page: () => const SupportScreen(),
    //   binding: BindingsBuilder(
    //       () => Get.lazyPut<SupportController>(() => SupportController())),
    //   transition: Transition.cupertino,
    // ),
  ];
}

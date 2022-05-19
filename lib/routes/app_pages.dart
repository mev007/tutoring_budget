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
import 'package:tutoring_budget/screen/edit_lesson/edit_lesson_controller.dart';
import 'package:tutoring_budget/screen/edit_lesson/edit_lesson_screen.dart';
import 'package:tutoring_budget/screen/edit_student/edit_student_controller.dart';
import 'package:tutoring_budget/screen/edit_student/edit_student_screen.dart';
import 'package:tutoring_budget/screen/filter_search/filter_search_controller.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.BOARD,
      page: () => const BoardScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<BoardController>(() => BoardController());
        Get.put<FillterSearchController>(
          FillterSearchController(),
          permanent: true,
        );
      }),
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
      page: () => const AddFinanceScreen(),
      binding: BindingsBuilder(() =>
          Get.lazyPut<AddFinanceController>(() => AddFinanceController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.ADD_LESSON,
      page: () => const AddLessonScreen(),
      binding: BindingsBuilder(
          () => Get.lazyPut<AddLessonController>(() => AddLessonController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.EDIT_LESSON,
      page: () => const EditLessonScreen(),
      binding: BindingsBuilder(() =>
          Get.lazyPut<EditLessonController>(() => EditLessonController())),
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
      binding: BindingsBuilder(() => Get.lazyPut<DetailStudentController>(
          () => DetailStudentController())),
      transition: Transition.cupertino,
    ),
  ];
}

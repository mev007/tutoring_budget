import 'package:get/get.dart';
import 'package:tutoring_budget/screen/FINANCES/add_finance/add_finance_controller.dart';
import 'package:tutoring_budget/screen/FINANCES/add_finance/add_finance_screen.dart';
import 'package:tutoring_budget/screen/FINANCES/filter_search/filter_search_controller.dart';
import 'package:tutoring_budget/screen/LESSONS/add_lesson/add_lesson_controller.dart';
import 'package:tutoring_budget/screen/LESSONS/add_lesson/add_lesson_screen.dart';
import 'package:tutoring_budget/screen/LESSONS/edit_lesson/edit_lesson_controller.dart';
import 'package:tutoring_budget/screen/LESSONS/edit_lesson/edit_lesson_screen.dart';
import 'package:tutoring_budget/screen/SETTING/category/category_controller.dart';
import 'package:tutoring_budget/screen/SETTING/category/category_screen.dart';
import 'package:tutoring_budget/screen/SETTING/communication/communication_controller.dart';
import 'package:tutoring_budget/screen/SETTING/communication/communication_screen.dart';
import 'package:tutoring_budget/screen/SETTING/language/language_controller.dart';
import 'package:tutoring_budget/screen/SETTING/language/language_screen.dart';
import 'package:tutoring_budget/screen/SETTING/support/support_controller.dart';
import 'package:tutoring_budget/screen/SETTING/support/support_screen.dart';
import 'package:tutoring_budget/screen/STUDENT/add_student/add_student_controller.dart';
import 'package:tutoring_budget/screen/STUDENT/add_student/add_student_screen.dart';
import 'package:tutoring_budget/screen/STUDENT/detail_student/detail_student_controller.dart';
import 'package:tutoring_budget/screen/STUDENT/detail_student/detail_student_screen.dart';
import 'package:tutoring_budget/screen/STUDENT/edit_student/edit_student_controller.dart';
import 'package:tutoring_budget/screen/STUDENT/edit_student/edit_student_screen.dart';
import 'package:tutoring_budget/screen/board/board_controller.dart';
import 'package:tutoring_budget/screen/board/board_screen.dart';

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
    GetPage(
      name: AppRoutes.LANGUAGE,
      page: () => LanguageScreen(),
      binding: BindingsBuilder(() => Get.lazyPut<LanguageController>(
          () => LanguageController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.CATEGORY,
      page: () => const CategoryScreen(),
      binding: BindingsBuilder(() => Get.lazyPut<CategoryController>(
          () => CategoryController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.COMMUNICATION,
      page: () => const CommunicationScreen(),
      binding: BindingsBuilder(() => Get.lazyPut<CommunicationController>(
          () => CommunicationController())),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.SUPPORT,
      page: () => const SupportScreen(),
      binding: BindingsBuilder(() => Get.lazyPut<SupportController>(
          () => SupportController())),
      transition: Transition.cupertino,
    ),
  ];
}

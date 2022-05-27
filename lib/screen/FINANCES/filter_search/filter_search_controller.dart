import 'package:get/get.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/utils.dart';

import '../finance_controll.dart';

class FillterSearchController extends GetxController {
  /// Вибраний студент
  StudentModel? selectStudent;

  /// Подія вибору студента
  onChangeStudent(StudentModel item) {
    selectStudent = item;
    selectCategory = null;
    selectVideo = null;
    update();
  }

  /// Подія вибору студента
  onClearStudent() {
    selectStudent = null;
    update();
  }

  String? selectCategory;

  String? selectVideo;

  onChangeCategory(String item) {
    selectCategory = item;
    selectStudent = null;
    update();
  }

  onClearCategory() {
    selectCategory = null;
    update();
  }

  onChangeVideo(String item) {
    selectVideo = item;
    selectStudent = null;
    update();
  }

  onClearVideo() {
    selectVideo = null;
    update();
  }

  /// Дата періоду
  DateTime? selectFromDateTime;
  DateTime? selectToDateTime;

  onChangeFromDate(DateTime? picked) {
    if (picked != null) selectFromDateTime = picked;
    update();
  }

  onClearFromDate() {
    selectFromDateTime = null;
    update();
  }

  onChangeToDate(DateTime? picked) {
    if (picked != null) selectToDateTime = picked;
    update();
  }

  onClearToDate() {
    selectToDateTime = null;
    update();
  }

  onApply() async {
    if (selectFromDateTime != null &&
        selectToDateTime != null &&
        selectFromDateTime!.isAfter(selectToDateTime!)) {
      Utils.messageError('Date range error'.tr);
      return;
    }
    final ctrl = Get.find<FinanceController>();
    List<String>? listStudentFilter;
    if (selectStudent != null) {
      listStudentFilter = [selectStudent!.id];
    } else if (selectCategory != null || selectVideo != null) {
      final response = await DB.selectIdStudent(selectCategory, selectVideo);
      if (response != null) {
        listStudentFilter =
            response.map((e) => StudentModel.fromMap(e).id).toList();
      } else {
        listStudentFilter = [];
      }
    }
    ctrl.listStudentFilter = listStudentFilter;
    if (selectFromDateTime != null) {
      // Встановлюємо на початок дати
      ctrl.fromDate = DateTime(selectFromDateTime!.year,
          selectFromDateTime!.month, selectFromDateTime!.day);
    } else {
      ctrl.fromDate = selectFromDateTime;
    }
    if (selectToDateTime != null) {
      // Встановлюємо на кінець дати
      ctrl.toDate = DateTime(selectToDateTime!.year, selectToDateTime!.month,
          selectToDateTime!.day, 23, 59, 59);
    } else {
      ctrl.toDate = selectToDateTime;
    }

    if (selectStudent != null) {
      ctrl.titleStudent =
          '${selectStudent!.firstName} ${selectStudent!.lastName}';
    } else {
      ctrl.titleStudent = '';
    }
    ctrl.titleCategor = selectCategory ?? '';
    ctrl.titleVideo = selectVideo ?? '';
    ctrl.titleDate = (selectFromDateTime == null)
        ? '- / '
        : '${Utils.getDate(selectFromDateTime)} / ';
    ctrl.titleDate +=
        (selectToDateTime == null) ? '-' : Utils.getDate(selectToDateTime);
    if (ctrl.titleDate == '- / -') {
      ctrl.titleDate = '';
    }
    ctrl.getListFinance();
    Get.back();
  }
}

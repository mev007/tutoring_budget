import 'package:get/get.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/finance/finance_controll.dart';
import 'package:tutoring_budget/utils.dart';

class FillterSearchController extends GetxController {
  /// Вибраний студент
  StudentModel? selectStudent;

  /// Подія вибору студента
  onChangeStudent(StudentModel item) {
    selectStudent = item;
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
    update();
  }

  onClearCategory() {
    selectCategory = null;
    update();
  }

  onChangeVideo(String item) {
    selectVideo = item;
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
    ctrl.fromDate = selectFromDateTime;
    ctrl.toDate = selectToDateTime;
    ctrl.titleCategorVideo = '${selectCategory ?? '-'} / ${selectVideo ?? '-'}';
    ctrl.titleDate = (selectFromDateTime == null)
        ? '- / '
        : '${Utils.getDate(selectFromDateTime)} / ';
    ctrl.titleDate +=
        (selectToDateTime == null) ? '-' : Utils.getDate(selectToDateTime);
    ctrl.getListFinance();
    Get.back();
  }

  // var radioWarrantyState = 999.obs;

  // var radioConfirmationState = 999.obs;

  // late bool isStore;

  // @override
  // void onInit() {
  //   init();
  //   isStore = AccountService.isStore;
  //   super.onInit();
  // }

  // init() {
  //   switch (filterData!.warrantyState) {
  //     case WarrantyState.ACTIVE:
  //       radioWarrantyState.value = 1;
  //       break;
  //     case WarrantyState.WILL_BE_COMPLETED_SOON:
  //       radioWarrantyState.value = 2;
  //       break;
  //     case WarrantyState.COMPLETED:
  //       radioWarrantyState.value = 3;
  //       break;
  //     case WarrantyState.HIDDEN:
  //       radioWarrantyState.value = 4;
  //       break;
  //     default:
  //       radioWarrantyState.value = 999;
  //       break;
  //   }

  //   switch (filterData!.confirmationState) {
  //     case WarrantyConfirmationState.NOT_CONFIRMED_BY_STORE:
  //       radioConfirmationState.value = 1;
  //       break;
  //     case WarrantyConfirmationState.WAITING_FOR_CONFIRMATION:
  //       radioConfirmationState.value = 2;
  //       break;
  //     case WarrantyConfirmationState.CONFIRMED:
  //       radioConfirmationState.value = 3;
  //       break;
  //     case WarrantyConfirmationState.WAITING_FOR_CHANGE_CONFIRMATION:
  //       radioConfirmationState.value = 4;
  //       break;
  //     case WarrantyConfirmationState.REJECTED_BY_STORE:
  //       radioConfirmationState.value = 5;
  //       break;
  //     default:
  //       radioConfirmationState.value = 999;
  //       break;
  //   }

  //   update();
  // }

  // onClear() {
  //   isStore
  //       ? Get.find<DashboardStoreController>()
  //           .onFilter(FilterModel(storeId: filterData!.storeId))
  //       : Get.find<DashboardClientController>()
  //           .onFilter(FilterModel(accountId: filterData!.accountId));
  //   SystemChannels.textInput.invokeMethod('TextInput.hide');
  //   Get.back();
  // }

  // onConfirm() {
  //   isStore
  //       ? Get.find<DashboardStoreController>().onFilter(filterData!)
  //       : Get.find<DashboardClientController>().onFilter(filterData!);
  //   SystemChannels.textInput.invokeMethod('TextInput.hide');
  //   Get.back();
  // }

  // ///Вибір радіо-кнопки в фільтрові WarrantyState
  // changeWarrantyState(int val) {
  //   radioWarrantyState.value = val;
  //   switch (val) {
  //     case 1:
  //       filterData!.warrantyState = WarrantyState.ACTIVE;
  //       break;
  //     case 2:
  //       filterData!.warrantyState = WarrantyState.WILL_BE_COMPLETED_SOON;
  //       break;
  //     case 3:
  //       filterData!.warrantyState = WarrantyState.COMPLETED;
  //       break;
  //     case 4:
  //       filterData!.warrantyState = WarrantyState.HIDDEN;
  //       break;
  //     default:
  //       filterData!.warrantyState = null;
  //       break;
  //   }
  //   update();
  // }

  // ///Вибір радіо-кнопки в фільтрові ConfirmationState
  // changeConfirmationState(int val) {
  //   radioConfirmationState.value = val;
  //   switch (val) {
  //     case 1:
  //       filterData!.confirmationState =
  //           WarrantyConfirmationState.NOT_CONFIRMED_BY_STORE;
  //       break;
  //     case 2:
  //       filterData!.confirmationState =
  //           WarrantyConfirmationState.WAITING_FOR_CONFIRMATION;
  //       break;
  //     case 3:
  //       filterData!.confirmationState = WarrantyConfirmationState.CONFIRMED;
  //       break;
  //     case 4:
  //       filterData!.confirmationState =
  //           WarrantyConfirmationState.WAITING_FOR_CHANGE_CONFIRMATION;
  //       break;
  //     case 5:
  //       filterData!.confirmationState =
  //           WarrantyConfirmationState.REJECTED_BY_STORE;
  //       break;
  //     default:
  //       filterData!.confirmationState = null;
  //       break;
  //   }
  //   update();
  // }
}

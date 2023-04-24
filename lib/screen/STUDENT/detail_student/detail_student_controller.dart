import 'package:get/get.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/lessons_model.dart';
import 'package:tutoring_budget/models/student_model.dart';
import 'package:tutoring_budget/screen/FINANCES/finance_controll.dart';
import 'package:tutoring_budget/screen/lessons/lessons_controller.dart';
import 'package:tutoring_budget/utils.dart';

class DetailStudentController extends GetxController {
  /// Студент
  StudentModel student = StudentModel();
  var sumF = 0.0.obs;
  var sumL = 0.0.obs;
  var sum = 0.0.obs;

  /// Список занять
  List<LessonsModel> listLessons = <LessonsModel>[];
  List<LessonsModel> listLessonsFilter = <LessonsModel>[];

  var isFilter = false.obs;

  @override
  Future<void> onInit() async {
    student = Get.arguments as StudentModel;
    await getListLessons();
    update();
    super.onInit();
  }

  /// Отримання списку модельок уроків
  Future getListLessons() async {
    final response = await DB.queryDateOnId(
      LessonsModel.nameTable,
      'idStudent',
      student.id,
    );
    if (response == null) return;
    sumF.value = await sumFinance();
    sumL.value = await sumLessons();
    sum.value = sumF.value - sumL.value;

    listLessons = response.map((e) => LessonsModel.fromMap(e)).toList();
    if (listLessons.length > 1) {
      listLessons.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    }

    var s = sumF.value;
    for (var item in listLessons) {
      s = s - item.cost;
      item.balance = s;
    }

    listLessonsFilter = List.from(listLessons);
    onPressFilter();
    update();
  }

  onPressFilter() {
    isFilter.value = !isFilter.value;
    if (isFilter.value) {
      listLessonsFilter = listLessons
          .where((element) =>
              Utils.integerFromDateTime(element.dateTime) >=
                  Utils.integerFromDateTime(DateTime.now()) ||
              element.balance < 0)
          .toList();
    } else {
      listLessonsFilter = List.from(listLessons);
    }
    update();
  }

  Future<double> sumFinance() async {
    final listFinance =
        await Get.find<FinanceController>().totalPayment(idStudent: student.id);
    double sumFinance = 0;
    if (listFinance != null) {
      for (var item in listFinance) {
        sumFinance += item.sum;
      }
    }
    return sumFinance;
  }

  Future<double> sumLessons() async {
    final listLessons = await Get.find<LessonsController>()
        .totalPayment(idStudent: student.id, toDateTime: DateTime.now());
    double sumFinance = 0;
    if (listLessons != null) {
      for (var item in listLessons) {
        sumFinance += item.cost;
      }
    }
    return sumFinance;
  }
}

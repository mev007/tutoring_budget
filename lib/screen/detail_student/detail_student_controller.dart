import 'package:get/get.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/models/lessons_model.dart';
import 'package:tutoring_budget/models/student_model.dart';

class DetailStudentController extends GetxController {
  /// Студент
  StudentModel student = StudentModel();

  /// Список занять
  List<LessonsModel> listLessons = <LessonsModel>[];

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
    listLessons = response.map((e) => LessonsModel.fromMap(e)).toList();
    if (listLessons.length > 1) {
      listLessons.sort((a, b) => -a.dateTime.compareTo(b.dateTime));
    }
    update();
  }
}

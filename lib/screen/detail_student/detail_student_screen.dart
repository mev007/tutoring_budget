import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants/constants.dart';
import 'package:tutoring_budget/screen/detail_student/detail_student_controller.dart';
import 'package:tutoring_budget/utils.dart';

class DetailStudentScreen extends StatelessWidget {
  const DetailStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailStudentScreen'.tr,
            maxLines: 2, textAlign: TextAlign.center),
        centerTitle: true,
        actions: [Utils.changeLocateBtt()],
      ),
      body: GetBuilder<DetailStudentController>(
        builder: (ctrl) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                _buildInfoStudent(),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ctrl.listLessons.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: MAIN_COLOR, height: 1),
                  itemBuilder: (_, i) {
                    final item = ctrl.listLessons[i];
                    final isFuture = Utils.integerFromDateTime(item.dateTime) >=
                        Utils.integerFromDateTime(DateTime.now());
                    return ListTile(
                      leading: isFuture
                          ? const Icon(Icons.update, color: EDIT_FON_COLOR)
                          : const Icon(Icons.done_all, color: Colors.green),
                      trailing: SizedBox(
                        width: 40,
                        child: CircleAvatar(
                          backgroundColor: ADD_COLOR,
                          child: Text(item.cost.toStringAsFixed(0),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      title: Text(Utils.getDateTime(item.dateTime)),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //#  ===============   ДОДАТКОВІ МЕТОДИ   =================
  /// Інформація про УЧНЯ
  Widget _buildInfoStudent() {
    final ctrl = Get.find<DetailStudentController>();

    return Card(
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: MAIN_COLOR, width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeText('${ctrl.student.firstName} ${ctrl.student.lastName}',
                textAlign: TextAlign.center,
                style: STYLE_PARAM,
                minFontSize: 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: CircleAvatar(
                    backgroundColor: ICON_COLOR,
                    child: Text(ctrl.student.cost.toStringAsFixed(0),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    foregroundColor: Colors.white,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      AutoSizeText(ctrl.student.adress,
                          textAlign: TextAlign.center,
                          minFontSize: 10,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AutoSizeText(ctrl.student.category,
                              textAlign: TextAlign.center,
                              minFontSize: 10,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          AutoSizeText(ctrl.student.video,
                              textAlign: TextAlign.center,
                              minFontSize: 10,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ctrl.student.note.isEmpty
                ? const SizedBox.square()
                : Column(
                    children: [
                      const SizedBox(height: 10),
                      AutoSizeText(ctrl.student.note,
                          textAlign: TextAlign.center,
                          minFontSize: 10,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

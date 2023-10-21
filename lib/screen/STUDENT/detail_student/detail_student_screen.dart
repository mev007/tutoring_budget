import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/screen/STUDENT/detail_student/detail_student_controller.dart';
import 'package:tutoring_budget/utils.dart';
import 'package:tutoring_budget/widgets/custom_appbar.dart';

class DetailStudentScreen extends StatelessWidget {
  const DetailStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailStudentController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: CustomAppBar(
              title: 'Student info'.tr, actions: const [_BttFilter()]),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _buildInfoStudent(),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: ctrl.listLessonsFilter.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: MAIN_COLOR, height: 1),
                    itemBuilder: (_, i) {
                      final item = ctrl.listLessonsFilter[i];
                      final isFuture =
                          Utils.integerFromDateTime(item.dateTime) >=
                              Utils.integerFromDateTime(DateTime.now());
                      return ListTile(
                        leading: isFuture
                            ? const Icon(Icons.update, color: EDIT_FON_COLOR)
                            : const Icon(Icons.done_all, color: Colors.green),
                        trailing: SizedBox(
                          width: 40,
                          child: CircleAvatar(
                            backgroundColor:
                                item.balance < 0 ? DEL_FON_COLOR : GREEN_COLOR,
                            foregroundColor: Colors.white,
                            child: Text(item.cost.toStringAsFixed(0),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        title: Text(Utils.getDateTime(item.dateTime)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      AutoSizeText(ctrl.student.category,
                          textAlign: TextAlign.center,
                          minFontSize: 10,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      CircleAvatar(
                        backgroundColor: ICON_COLOR,
                        foregroundColor: Colors.white,
                        child: Text(ctrl.student.cost.toStringAsFixed(0),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      AutoSizeText(ctrl.student.video,
                          textAlign: TextAlign.center,
                          minFontSize: 10,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      AutoSizeText(
                          '${ctrl.student.firstName} ${ctrl.student.lastName}',
                          textAlign: TextAlign.center,
                          style: STYLE_PARAM,
                          minFontSize: 10,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 5),
                      ctrl.student.adress.isEmpty
                          ? const SizedBox.shrink()
                          : AutoSizeText(ctrl.student.adress,
                              textAlign: TextAlign.center,
                              minFontSize: 10,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                      ctrl.student.adress.isEmpty
                          ? const SizedBox.shrink()
                          : const SizedBox(height: 5),
                      _buildSum(),
                      _buildNote(ctrl),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNote(DetailStudentController ctrl) {
    return ctrl.student.note.isEmpty
        ? const SizedBox.square()
        : Column(
            children: [
              const SizedBox(height: 5),
              AutoSizeText(ctrl.student.note,
                  textAlign: TextAlign.center,
                  minFontSize: 10,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis),
            ],
          );
  }

  Widget _buildSum() {
    final ctrl = Get.find<DetailStudentController>();
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${ctrl.sumF.value.toStringAsFixed(0)} - ${ctrl.sumL.value.toStringAsFixed(0)} = ',
            ),
            Text(
              ctrl.sum.value.toStringAsFixed(0),
              style: TextStyle(
                  color: ctrl.sum.value < 0 ? DEL_FON_COLOR : GREEN_COLOR,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}

class _BttFilter extends GetView<DetailStudentController> {
  /// Кнопка фільтрування списку
  const _BttFilter();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: IconButton(
        tooltip: 'Фільтр для списку'.tr,      
        splashRadius: 24,
        onPressed: () => controller.onPressFilter(),
        icon: Obx(() => Icon(
              controller.isFilter.value ? Iconsax.eye_slash : Iconsax.eye,
              color: Colors.white,
            )),
      ),
    );
  }
}

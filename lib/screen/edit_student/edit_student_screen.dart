import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/screen/edit_student/edit_student_controller.dart';
import 'package:tutoring_budget/widgets/Btt.dart';
import 'package:tutoring_budget/widgets/BuildTextField.dart';
import 'package:tutoring_budget/widgets/change_locate_btt.dart';

class EditStudentScreen extends StatelessWidget {
  const EditStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editing a student'.tr, maxLines: 2),
          actions: const [ChangeLocaleBtt()],
        ),
        body: GetBuilder<EditStudentController>(
          builder: (ctrl) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    BuildTextField(
                      labelText: 'First name'.tr,
                      keyboardType: TextInputType.text,
                      controller: ctrl.firstNameController,
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 10),
                    BuildTextField(
                      labelText: 'Last name'.tr,
                      keyboardType: TextInputType.text,
                      controller: ctrl.lastNameController,
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 10),
                    BuildTextField(
                      labelText: 'Contact details'.tr,
                      keyboardType: TextInputType.text,
                      controller: ctrl.adressNameController,
                      prefixIcon: Icons.mail_outline,
                    ),
                    const SizedBox(height: 10),
                    _buildCategory(ctrl),
                    const SizedBox(height: 10),
                    _buildVideo(ctrl),
                    const SizedBox(height: 10),
                    BuildTextField(
                      labelText: 'Ціна одного заняття'.tr,
                      keyboardType: TextInputType.number,
                      controller: ctrl.costNameController,
                      prefixIcon: Icons.monetization_on_outlined,
                    ),
                    const SizedBox(height: 10),
                    BuildTextField(
                      labelText: 'Примітка'.tr,
                      keyboardType: TextInputType.multiline,
                      controller: ctrl.noteNameController,
                      maxLines: 5,
                      height: 100,
                      prefixIcon: Icons.notes,
                    ),
                    const SizedBox(height: 10),
                    SafeArea(
                      child: Btt(
                        title: 'Save'.tr,
                        onPress: ctrl.onSave,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //# =================================
  Widget _buildCategory(EditStudentController ctrl) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(216, 216, 216, 0.25),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Категорія навчання'.tr,
          floatingLabelStyle: const TextStyle(color: BTT_COLOR),
          prefixIcon: const Icon(Icons.cast_for_education, color: MAIN_COLOR),
          border: BORDER_DROPDOWN,
          focusedBorder: BORDER_DROPDOWN,
          enabledBorder: BORDER_DROPDOWN,
          errorBorder: BORDER_DROPDOWN,
          disabledBorder: BORDER_DROPDOWN,
          contentPadding: const EdgeInsets.fromLTRB(0, 15, 5, 15),
        ),
        items: listCategory
            .map((e) => DropdownMenuItem(child: Text(e), value: e))
            .toList(),
        onChanged: (e) => ctrl.onChangeCategory(e.toString()),
        value: ctrl.selectCategory,
      ),
    );
  }

  Widget _buildVideo(EditStudentController ctrl) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(216, 216, 216, 0.25),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Програма спілкування'.tr,
          floatingLabelStyle: const TextStyle(color: BTT_COLOR),
          prefixIcon: const Icon(Icons.personal_video, color: MAIN_COLOR),
          border: BORDER_DROPDOWN,
          focusedBorder: BORDER_DROPDOWN,
          enabledBorder: BORDER_DROPDOWN,
          errorBorder: BORDER_DROPDOWN,
          disabledBorder: BORDER_DROPDOWN,
          contentPadding: const EdgeInsets.fromLTRB(0, 15, 5, 15),
        ),
        items: listVideo
            .map((e) => DropdownMenuItem(child: Text(e), value: e))
            .toList(),
        onChanged: (e) => ctrl.onChangeVideo(e.toString()),
        value: ctrl.selectVideo,
      ),
    );
  }
}

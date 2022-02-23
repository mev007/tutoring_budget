import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants/constants.dart';
import 'package:tutoring_budget/utils.dart';
import 'package:tutoring_budget/widgets/Btt.dart';
import 'package:tutoring_budget/widgets/BuildTextField.dart';

import 'add_student_controller.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  final border = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(color: MAIN_COLOR, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('AddStudentScreen'.tr,
              maxLines: 2, textAlign: TextAlign.center),
          actions: [Utils.changeLocateBtt()],
        ),
        body: GetBuilder<AddStudentController>(
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
  Widget _buildCategory(AddStudentController ctrl) {
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
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          errorBorder: border,
          disabledBorder: border,
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

  Widget _buildVideo(AddStudentController ctrl) {
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
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          errorBorder: border,
          disabledBorder: border,
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

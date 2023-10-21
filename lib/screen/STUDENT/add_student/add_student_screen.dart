import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';
import 'package:tutoring_budget/sp.dart';
import 'package:tutoring_budget/widgets/Btt.dart';
import 'package:tutoring_budget/widgets/BuildTextField.dart';
import 'package:tutoring_budget/widgets/custom_appbar.dart';
import 'package:tutoring_budget/widgets/my_icon.dart';

import 'add_student_controller.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Adding a student'.tr),
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
          prefixIcon: const MyIcon(Icons.cast_for_education),
          border: BORDER_DROPDOWN,
          focusedBorder: BORDER_DROPDOWN,
          enabledBorder: BORDER_DROPDOWN,
          errorBorder: BORDER_DROPDOWN,
          disabledBorder: BORDER_DROPDOWN,
          contentPadding: const EdgeInsets.fromLTRB(0, 15, 5, 15),
        ),
        items: SP.listCategory
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
          prefixIcon: const MyIcon(Icons.personal_video),
          border: BORDER_DROPDOWN,
          focusedBorder: BORDER_DROPDOWN,
          enabledBorder: BORDER_DROPDOWN,
          errorBorder: BORDER_DROPDOWN,
          disabledBorder: BORDER_DROPDOWN,
          contentPadding: const EdgeInsets.fromLTRB(0, 15, 5, 15),
        ),
        items: SP.listVideo
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (e) => ctrl.onChangeVideo(e.toString()),
        value: ctrl.selectVideo,
      ),
    );
  }
}

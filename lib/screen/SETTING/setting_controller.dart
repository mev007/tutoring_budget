import 'package:get/get.dart';
import 'package:tutoring_budget/themes/app_theme.dart';

class SettingController extends GetxController {
  var valSwitch = false.obs;

  onChangeSwitch(bool val) {
    valSwitch.value = !valSwitch.value;
    Get.changeTheme(Get.isDarkMode ? AppTheme.light : AppTheme.dark);
  }
}

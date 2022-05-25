import 'package:get/get.dart';

class BoardController extends GetxController {
  var tabIndex = 1;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  
}

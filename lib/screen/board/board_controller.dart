import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardController extends GetxController {
  var tabIndex = 1;

  var appBarKey = GlobalKey<ConvexAppBarState>();

  void changeTabIndex(int index) {
    tabIndex = index;
    appBarKey.currentState?.animateTo(tabIndex);
    update();
  }
}

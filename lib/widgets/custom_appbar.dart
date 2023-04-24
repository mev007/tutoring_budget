import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.actions,
    this.height = kToolbarHeight,
    this.onBack,
    this.leading,
    this.titleColor,
    this.isVisibleLeadingBtn = true,
  });

  final String title;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final double height;
  final void Function()? onBack;
  final Widget? leading;
  final bool isVisibleLeadingBtn;
  final Color? titleColor;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, maxLines: 2, textAlign: TextAlign.center),
      centerTitle: true,
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //   statusBarColor: Colors.black,
      // ),
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: Colors.white,
      //   // For Android (dark icons)
      //   statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
      //       ? Brightness.light
      //       : Brightness.dark,
      //   // For iOS (dark icons)
      //   statusBarBrightness: Theme.of(context).brightness,
      // ),
      automaticallyImplyLeading: false,
      leading: isVisibleLeadingBtn
          ? leading ??
              IconButton(
                onPressed: onBack ?? () => Get.back(),
                splashRadius: 24,
                icon: Icon(Icons.arrow_back_ios_new,
                    color: titleColor ?? WHITE_COLOR, size: 20),
              )
          : const SizedBox.shrink(),
      actions: actions,
    );
  }
}



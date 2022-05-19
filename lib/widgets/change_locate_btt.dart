import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLocaleBtt extends StatelessWidget {
  const ChangeLocaleBtt({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final locale = Get.locale == const Locale('en', 'US')
            ? const Locale('uk', 'UA')
            : const Locale('en', 'US');
        // var locale = Locale('en', 'US');
        Get.updateLocale(locale);
      },
      child: const Icon(Icons.language, color: Colors.white,)
      // const Text(
      //   'en/ua',
      //   style: TextStyle(color: Colors.white),
      // ),
    );
  }
}

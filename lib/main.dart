// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/db.dart';
import 'package:tutoring_budget/language/language.dart';
import 'package:tutoring_budget/sp.dart';

import 'routes/app_pages.dart';
import 'themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SP.init();
  await DB.init();
  // Ініціалізаці для бібліотеки intl для locale: '${Get.locale}'
  // await initializeDateFormatting('uk_UA', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    print('deviceLocale = ${Get.deviceLocale}');
    return GetMaterialApp(
      title: 'Tutor budget',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppPages.list,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      translations: Language(),
      locale: Locale(SP.curentLanguage), //Get.deviceLocale,  //const Locale('uk', 'UA'), 
      fallbackLocale: const Locale('en', ''),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en'),
        Locale('uk'),
      ],
    );
  }
}




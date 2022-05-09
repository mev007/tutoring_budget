import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/db.dart';

import 'messages.dart';
import 'routes/app_pages.dart';
import 'themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  // Ініціалізаці для бібліотеки intl для locale: '${Get.locale}'
  // await initializeDateFormatting('uk_UA', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tutoring budget',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: AppPages.list,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      translations: Messages(),
      locale: const Locale('uk', 'UA'), //Get.deviceLocale,
      fallbackLocale: const Locale('uk', 'UA'),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('uk', 'UA'),
      ],
    );
  }
}




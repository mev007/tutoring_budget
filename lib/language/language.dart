import 'package:get/get.dart';

import 'en_language.dart';
import 'uk_language.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': EnLanguage.map,
        'uk_UA': UkLanguage.map,
        // 'ru_RU': RuLanguage.map,
      };
}

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// For SharedPreferences
class SP {
  static late SharedPreferences prefs;

  static Future<void> init() async =>
      prefs = await SharedPreferences.getInstance();

  static List<String> get listCategory {
    List<String>? lC = prefs.getStringList('listCategory');
    if (lC == null) {
      lC = [
        '10th grade',
        'ZNO',
      ];
      listCategory = lC;
    }
    return lC;
  }

  static set listCategory(List<String> val) =>
      prefs.setStringList('listCategory', val);

  static List<String> get listVideo {
    List<String>? lV = prefs.getStringList('listVideo');
    if (lV == null) {
      lV = [
        'Google Meet',
        'Microsoft Teams',
        'Skype',
        'Zoom',
      ];
      listVideo = lV;
    }
    return lV;
  }

  static bool findItemCategory(String itemCategory) =>
      listCategory.contains(itemCategory);

  static set listVideo(List<String> val) =>
      prefs.setStringList('listVideo', val);

  static String get curentLanguage {
    String? lang = prefs.getString('curentLanguage');
    if (lang == null) {
      lang = Get.deviceLocale?.languageCode ?? 'uk';
      curentLanguage = lang;
    }
    return lang;
  }

  static bool findItemVideo(String itemVideo) =>
      listVideo.contains(itemVideo);

  static set curentLanguage(String val) =>
      prefs.setString('curentLanguage', val);
}

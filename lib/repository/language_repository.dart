import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageRepository {
  String _currentLanguage = 'vi';
  SharedPreferences? prefs;

  static final String keySaveLanguage = "language";

  LanguageRepository() {
    init();
  }

  Future init() async {
    await getCurrentLang();
  }

  Future setCurrentLanguage(String lang) async {
    _currentLanguage = lang;
    await prefs!.setString(keySaveLanguage, lang);
  }

  Future<String> getCurrentLang() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      if (prefs == null) {
        prefs = await SharedPreferences.getInstance();
      }
      _currentLanguage = prefs!.getString(keySaveLanguage) ?? 'vi';
      return _currentLanguage;
    } catch (err) {
      debugPrint("LanguageRepository LanguageRepository error $err");
      return 'vi';
    }
  }
}

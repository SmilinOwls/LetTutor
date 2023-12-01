import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/models/language/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Language _language = languageList.first;

  Language get language => _language;

  set language(Language language) {
    _language = language;
    notifyListeners();
  }

  Language getLanguage() {
    getLanguageFromPreferences();
    return _language;
  }

  void getLanguageFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageId = prefs.getString("language") ?? 'en';
    language = languageList.firstWhere((lang) => lang.id == languageId);
  }

  void switchLanguage(Language language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language.id!);
    language = languageList.firstWhere((lang) => lang == language);
  }
}

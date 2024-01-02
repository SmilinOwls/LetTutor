import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/models/language/language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageProvider with ChangeNotifier {
  Language _language = languageList.first; // en

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
    String languageId = language.id!;
    if(!AppLocalizations.supportedLocales.contains(Locale(languageId))) {
      languageId = 'en';
    }
    prefs.setString('language', languageId);
    language = languageList.firstWhere((lang) => lang == language);
  }
}

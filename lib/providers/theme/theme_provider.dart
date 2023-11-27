import 'package:flutter/material.dart';
import 'package:lettutor/providers/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  bool isDark() {
    return _themeData == darkMode;
  }

  ThemeData getThemeMode() {
    getThemeModeFromPreferences();
    return _themeData;
  }

  void getThemeModeFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool("isDarkMode") ?? false;
    themeData = isDarkMode ? darkMode : lightMode;
  }

  void toggleTheme(bool isDarkMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
    themeData = isDarkMode ? darkMode : lightMode;
  }
}

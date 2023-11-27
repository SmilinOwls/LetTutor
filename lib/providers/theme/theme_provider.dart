import 'package:flutter/material.dart';
import 'package:lettutor/providers/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  bool isDarkMode() {
    return _themeData == darkMode;
  }

  void toggleTheme(bool isDarkMode) {
    if (isDarkMode == true) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}

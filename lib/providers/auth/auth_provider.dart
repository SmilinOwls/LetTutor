import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy.dart';
import 'package:lettutor/models/language/language.dart';
import 'package:lettutor/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  String finalId = '';

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  User? getUser() {
    getUserFromPreferences();
    return _user;
  }

  void getUserFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("user");
    finalId = userId ?? '';
  }

  void setUser(User? user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', finalId);
  }
}

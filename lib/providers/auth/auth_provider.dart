import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lettutor/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

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
    final userData = jsonDecode(prefs.getString("user")!);
    user = User.fromJson(userData);
  }

  void setUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user.toJson()));
    user = user;
  }
}

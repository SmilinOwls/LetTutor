import 'package:flutter/material.dart';
import 'package:lettutor/models/user/user.dart';
import 'package:lettutor/services/user_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  User? getUser() {
    getUserFromAPI();
    return _user;
  }

  void getUserFromAPI() async {
    await UserService.getUserInfo(
      onSuccess: (userInfo) {
        user = userInfo;
      },
      onError: (message) {
        throw Exception(message);
      },
    );
  }
}

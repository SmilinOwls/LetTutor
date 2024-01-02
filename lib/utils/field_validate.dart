import 'package:lettutor/utils/localization.dart';

class FieldValidate with Localization {
  static String? handleEmailValidate(String value) {
    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    if (value.isEmpty) {
      return Localization.local?.emptyEmail;
    } else if (!emailRegExp.hasMatch(value)) {
      return Localization.local?.invalidEmail;
    } else {
      return null;
    }
  }

  static String? handlePasswordValidate(String value) {
    if (value.isEmpty) {
      return Localization.local?.emptyPassword;
    } else if (value.length < 6) {
      return Localization.local?.invalidPassword;
    } else {
      return null;
    }
  }

  static String? handleRePasswordValidate(String value, String password) {
    if (value.isEmpty) {
      return Localization.local?.emptyRePassword;
    } else if (value.length < 6) {
      return Localization.local?.invalidRePassword;
    } else {
      if (value != password) {
        return Localization.local?.notMatchRePassword;
      } else {
        return null;
      }
    }
  }
}

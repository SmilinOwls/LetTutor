import 'package:flutter/material.dart';

class SnackBarHelper {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  static void showSuccessSnackBar({
    required BuildContext context,
    required String content,
  }) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          left: 10,
          right: 10,
        ),
      ),
    );
  }

  static void showErrorSnackBar({
    required BuildContext context,
    required String content,
  }) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          left: 10,
          right: 10,
        ),
      ),
    );
  }

  static void showInfoSnackBar({
    required BuildContext context,
    required String content,
  }) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          left: 10,
          right: 10,
        ),
      ),
    );
  }
}

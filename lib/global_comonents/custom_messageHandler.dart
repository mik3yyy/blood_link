import 'package:flutter/material.dart';

import '../settings/constants.dart';

class MyMessageHandler {
  static void showSnackBar(
      GlobalKey<ScaffoldMessengerState> scaffoldKey, String message) {
    scaffoldKey.currentState!.hideCurrentSnackBar();
    scaffoldKey.currentState!.showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Constants.darkPink,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        )));
  }
}

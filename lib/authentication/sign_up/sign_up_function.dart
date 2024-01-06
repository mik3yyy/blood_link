import 'package:blood_link/Firebase/auth.dart';
import 'package:blood_link/Firebase/storage.dart';
import 'package:blood_link/authentication/complete_donor_profile/basic_info.dart';
import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/print.dart';
import 'package:blood_link/settings/validators.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpFunction {
  static checkUser(
      {required String email,
      required String password,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey,
      required BuildContext context}) async {
    if (email.isValidEmail()) {
      if (password.length > 8) {
        try {
          bool user =
              await FirebaseStorageApi.doesUserWithEmailExist(email, 'donor');
          if (!user) {
            var authProvider =
                Provider.of<AuthenticationProvider>(context, listen: false);
            authProvider.fillProfile(e: email, p: password);

            Navigator.pushNamed(context, BasicInfoScreen.id);
          } else {
            MyMessageHandler.showSnackBar(scaffoldKey, 'User already exists');
          }
        } catch (e) {
          print(e.toString());
          MyMessageHandler.showSnackBar(scaffoldKey, 'Check your network');
        }
      } else {
        MyMessageHandler.showSnackBar(scaffoldKey, 'Enter a longer passwod');
      }
    } else {
      MyMessageHandler.showSnackBar(scaffoldKey, 'Enter a valid email');
    }
  }
}

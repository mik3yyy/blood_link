import 'package:blood_link/Firebase/auth.dart';
import 'package:blood_link/Firebase/storage.dart';
import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_home_screen/bank_main_screen.dart';
import 'package:blood_link/models/bank.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BloodLoginFunction {
  // static BloddBankLogin({
  //   required String email,
  //   required String password,
  //   required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  // }) async {

  // }
  static bloodLogin({
    required String email,
    required String password,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required BuildContext context,
  }) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    try {
      Map<String, dynamic> user = await FirebaseStorageApi.userDoc(
          email: email, password: password, collection: 'bank');
      if (user.isNotEmpty) {
        BloodBank bank = BloodBank.fromMap(user);
        Print(bank.toString());
        if (bank.password == Constants.hashPassword(password)) {
          authProvider.saveBank(bank);
          Navigator.pushNamed(context, BankMainScreen.id);
        } else {
          MyMessageHandler.showSnackBar(scaffoldKey, "Wrong email or password");
        }
      } else {
        MyMessageHandler.showSnackBar(scaffoldKey, "Wrong email or password");
      }
    } catch (e) {
      Print(e.toString());
      MyMessageHandler.showSnackBar(scaffoldKey, "Check your network");
    }
  }
}

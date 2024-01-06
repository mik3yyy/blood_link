import 'dart:convert';

import 'package:blood_link/Firebase/auth.dart';
import 'package:blood_link/Firebase/storage.dart';
import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:blood_link/main_screens/donor_main_screens/donor_main_screen.dart';
import 'package:blood_link/models/donor.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonormainFunction {
  static donorReload({
    required String email,
    required String password,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required BuildContext context,
  }) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    try {
      Map<String, dynamic> user = await FirebaseStorageApi.userDoc(
          email: email, password: password, collection: 'donor');
      if (user.isNotEmpty) {
        Donor donor = Donor.fromMap(user);
        if (donor.password == (password)) {
          authProvider.saveDonor(donor);
        } else {
          MyMessageHandler.showSnackBar(scaffoldKey, "Wrong email or password");
        }
      } else {
        MyMessageHandler.showSnackBar(scaffoldKey, "Wrong email or password");
      }
    } catch (e) {
      MyMessageHandler.showSnackBar(scaffoldKey, "Check your network");
    }
  }
}

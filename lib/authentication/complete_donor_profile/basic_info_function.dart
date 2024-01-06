import 'package:blood_link/Firebase/auth.dart';
import 'package:blood_link/Firebase/storage.dart';
import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:blood_link/main_screens/donor_main_screens/donor_main_screen.dart';
import 'package:blood_link/models/donor.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicInfoFunction {
  static completeProfile(
      {required Donor donor,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey,
      required BuildContext context}) async {
    try {
      var authProvider =
          Provider.of<AuthenticationProvider>(context, listen: false);
      var check = donor.isValidDonor();

      if (check == null) {
        await FirebaseStorageApi.addCollection(
            collection: 'donor', map: donor.toMap());
        authProvider.saveDonor(donor);

        Navigator.pushNamed(context, DonorMainScreen.id);
      } else {
        MyMessageHandler.showSnackBar(scaffoldKey, check);
      }
    } on FirebaseAuthException catch (e) {
      // Handle different Firebase Auth exceptions
      if (e.code == 'weak-password') {
        MyMessageHandler.showSnackBar(
            scaffoldKey, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        MyMessageHandler.showSnackBar(
            scaffoldKey, 'An account already exists for that email.');
      }
      rethrow; // Re-throw the exception to be handled elsewhere
    } catch (e) {
      MyMessageHandler.showSnackBar(scaffoldKey, "Check your network");
    }
  }
}

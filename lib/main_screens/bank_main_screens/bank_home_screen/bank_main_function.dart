import 'package:blood_link/Firebase/auth.dart';
import 'package:blood_link/Firebase/storage.dart';
import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_home_screen/bank_main_screen.dart';
import 'package:blood_link/models/bank.dart';
import 'package:blood_link/models/bloodType.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BloodBankMainFunction {
  // static BloddBankLogin({
  //   required String email,
  //   required String password,
  //   required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  // }) async {

  // }
  static bankReload({
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
        if (bank.password == (password)) {
          authProvider.saveBank(bank);
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

  static Future<void> updateBloodType({
    required BloodType dataToUpdate,
    required String field,
    required BuildContext context,
  }) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    // Get a reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to the specific document
    DocumentReference docRef =
        firestore.collection('inventory').doc(authProvider.bank!.bankId);

    try {
      // Update the document
      await docRef.update({field: dataToUpdate.toMap()});
      Navigator.pop(context);
      print('Document updated successfully');
    } catch (e) {
      // MyMessageHandler.showSnackBar(scaffoldKey, e.toString());
      // Handle any errors here
      print('Error updating document: $e');
    }
  }
}

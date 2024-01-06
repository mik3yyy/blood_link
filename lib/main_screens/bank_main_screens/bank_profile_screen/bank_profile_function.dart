import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankProfileFunction {
  static Future<void> editProfile(
      {required BloodBank bloodBank,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey,
      required BuildContext context}) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Query the collection for the document with the matching 'bankId'
    QuerySnapshot query = await firestore
        .collection('bank')
        .where('bankId', isEqualTo: bloodBank.bankId)
        .get();

    // Check if the document exists
    if (query.docs.isNotEmpty) {
      // Get the document reference
      DocumentReference docRef = query.docs.first.reference;

      // Update the document
      await docRef.update(bloodBank.toMap()).then((_) {
        MyMessageHandler.showSnackBar(
            scaffoldKey, 'Profile updated successfully');
        authProvider.saveBank(bloodBank);
      }).catchError((error) {
        MyMessageHandler.showSnackBar(scaffoldKey, 'Error updating profile');
      });
    } else {
      MyMessageHandler.showSnackBar(scaffoldKey, 'Profile not found');
    }
  }
}

import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileFunction {
  static Future<void> updateDonorByEmail({
    required Donor donor,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference donors = firestore.collection('donor');

    try {
      Print(authProvider.email);
      // Find the document with the matching email
      QuerySnapshot query =
          await donors.where('email', isEqualTo: donor.email).get();

      if (query.docs.isEmpty) {
        MyMessageHandler.showSnackBar(scaffoldKey, "No donor found with email");
        print('No donor found with email ${donor.email}');
        return;
      }

      // Assuming email is unique and there's only one document with this email
      DocumentReference donorDocRef = query.docs.first.reference;

      // Update the document with new data
      await donorDocRef.update(donor.toMap());
      authProvider.saveDonor(donor);
      Navigator.pop(context);
      print('Donor with email ${donor.email} updated successfully');
    } catch (e) {
      MyMessageHandler.showSnackBar(scaffoldKey, "Error updating donor");

      print('Error updating donor: $e');
    }
  }
}

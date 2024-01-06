import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/models/campaign.dart';
import 'package:blood_link/settings/print.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

class BankCampaignFunction {
  static Future<bool> createAndUploadCampaign(
      {required String bankId,
      required File imageFile,
      required String campaignTitle,
      required String description,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey,
      required BuildContext context}) async {
    // Generate a UUID for the image

    // Upload image to Firebase Storage
    try {
      String imageFileName = Uuid().v4();

      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref('campaigns/$imageFileName')
          .putFile(imageFile);

      // Get the image URL
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Create a Campaign instance
      Campaign campaign = Campaign(
        bankId: bankId,
        image: imageUrl,
        timestap: DateTime.now().toIso8601String(),
        campaignTitle: campaignTitle,
        description: description,
      );
      MyMessageHandler.showSnackBar(
          scaffoldKey, "Campaign Upoaded Successfully");

      // Upload campaign data to Firestore
      await FirebaseFirestore.instance
          .collection('campaigns')
          .add(campaign.toMap());
      return true;
    } catch (e) {
      MyMessageHandler.showSnackBar(scaffoldKey, "Error Upoading Campaign");
      return false;
    }
  }

  static Future<void> deleteDocument({
    required String documentId,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('campaigns')
          .doc(documentId)
          .delete();
      MyMessageHandler.showSnackBar(
          scaffoldKey, "Campaign Deleted Successfully");
    } catch (e) {
      MyMessageHandler.showSnackBar(scaffoldKey, "Error Deleting Campaign");
    }
  }
}

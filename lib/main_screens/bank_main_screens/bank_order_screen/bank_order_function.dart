import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BankOrderFunction {
  static Future<void> updateRequestStatus(
      {required String docId,
      required String newStatus,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey,
      required BuildContext context}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference requestDocRef =
        firestore.collection('Request').doc(docId);

    try {
      await requestDocRef.update({'status': newStatus});
      MyMessageHandler.showSnackBar(scaffoldKey, "Order Details Updated");
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
      print('Request status updated successfully');
    } catch (e) {
      print('Error updating request status: $e');
    }
  }
}

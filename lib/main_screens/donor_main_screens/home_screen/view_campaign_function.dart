import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/main_screens/donor_main_screens/book_appointment/book_appointment_screen.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewCampaignFunction {
  static Future<void> getBankDocumentById({
    required String bankId,
    required BuildContext context,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    try {
      // Get the document for the specified bankId from the 'banks' collection

      // DocumentSnapshot documentSnapshot =
      //     await FirebaseFirestore.instance.collection('bank')
      //     .where('bankId', isEqualTo: bankId)
      //   .limit(1) // Assuming 'bankId' is unique, there should be at most one document.
      //   .get();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bank')
          .where('bankId', isEqualTo: bankId)
          .limit(1)
          .get();

      if (querySnapshot.docs.first.exists) {
        // Cast the data to Map<String, dynamic> and return it
        var m = querySnapshot.docs.first.data() as Map<String, dynamic>;
        BloodBank bloodBank = BloodBank.fromMap(m);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookAppointmentScreen(bank: bloodBank)));
      } else {
        print('Nod bank foun with id: $bankId');
        MyMessageHandler.showSnackBar(scaffoldKey, "Can't Find Bank");
      }
    } catch (e) {
      MyMessageHandler.showSnackBar(scaffoldKey, "Error Finding Bank");

      print('Error getting bank document: $e');
    }
  }
}

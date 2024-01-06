import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/models/appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentFunction {
  static Future<void> updateFirstAppointmentStatusByEmail({
    required Appointment appointment,
    required String newStatus,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Reference to the 'Appointments' collection
      CollectionReference appointments = firestore.collection('Appointments');

      // Get the first document where 'email' matches the appointment's email
      QuerySnapshot querySnapshot = await appointments
          .where('timestamp', isEqualTo: appointment.timestamp)
          .limit(1) // Limits to the first document found
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document's reference
        DocumentReference docRef = querySnapshot.docs.first.reference;

        // Update the 'status' field of this document
        await docRef.update({'status': newStatus});
        MyMessageHandler.showSnackBar(
            scaffoldKey, "Appointment status updated successfully");
        print('Appointment status updated successfully');
      } else {
        print('No appointment found for the given email');
        MyMessageHandler.showSnackBar(
            scaffoldKey, "No appointment found for the given email");
      }
    } catch (e) {
      MyMessageHandler.showSnackBar(
          scaffoldKey, "Error updating appointment status: ");

      print('Error updating appointment status: $e');
    }
  }
}

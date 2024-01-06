import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/models/appointment.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAppointmentFunction {
  static Future<void> updateAppointmentsByTimestamp({
    required Appointment appointment,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required BuildContext context,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference appointments = firestore.collection('Appointments');

    try {
      // Query the appointments with the specific timestamp
      QuerySnapshot querySnapshot = await appointments
          .where('timestamp', isEqualTo: appointment.timestamp)
          .get();
      Print(querySnapshot.docs.isEmpty);

      // Iterate through the documents and update each one
      var doc = querySnapshot.docs.first;
      await doc.reference.update(appointment.toMap());

      MyMessageHandler.showSnackBar(scaffoldKey, "Appointment Rescheduled");
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } catch (e) {
      Print(e.toString());
      MyMessageHandler.showSnackBar(
          scaffoldKey, "Error while Rescheduling Appointment");
    }
  }
}

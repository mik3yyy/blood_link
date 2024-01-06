import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/models/appointment.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'book_success_screen.dart';

class BookAppointmentFunction {
  static Future<void> addAppointmentToFirebase(
      {required Appointment appointment,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey,
      required BuildContext context}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference appointments = firestore.collection('Appointments');

    try {
      // Add the Appointment to the 'Appointments' collection
      DocumentReference docRef = await appointments.add(appointment.toMap());
      // MyMessageHandler.showSnackBar(scaffoldKey,"Appoint")
      Print('Appointment added with ID: ${docRef.id}');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AppointmentSuccess()));
    } catch (e) {
      MyMessageHandler.showSnackBar(
          scaffoldKey, "Error Scheduling Appointment");

      Print('Error adding appointment: $e');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthentication {
  static Future<UserCredential> createUser({
    required String email,
    required String password,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  }) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static convertDateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }

  static DateTime convertTimestampToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }
}

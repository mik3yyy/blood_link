import 'dart:convert';

import 'package:blood_link/settings/print.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Constants {
  static String url = "http://api.devbracket.tech/api/v1";
  //"http://api.devbracket.tech/api/v1";
  //https://api.kiasup.com/api/v1

  //COLOUR
  static Color grey = Colors.grey;
  static Color white = Color(0xFFFFFFFF);
  static Color transperent = Colors.transparent;

  static Color black = Colors.black;
  static Color orange = Color(0xFFEA985B);
  static Color primaryPink = Color(0xFFF4739E);
  static Color darkPink = Color(0xFFFF4881);

  static Map<String, dynamic> DonorMainColor = {
    "find": {
      "icon": Color(0xFFFA6393),
      "bg": Color(0xFFFA6393).withOpacity(0.4)
    },
    "request": {
      "icon": Color(0xFFF5B800),
      "bg": Color(0xFFF5B800).withOpacity(0.4),
    },
    "bank": {
      "icon": Color(0xFF00CC99),
      "bg": Color(0xFF00CC99).withOpacity(0.4)
    },
    "other": {
      "icon": Color(0xFF999999),
      "bg": Color(0xFF999999).withOpacity(0.4),
    },
    "subTitle": Color(0xFF519FE8)
  };
// F7A1A3
  ///STYLE
  static TextStyle title = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.w600,
  );
  static TextStyle Montserrat = GoogleFonts.montserrat();

  static BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Constants.grey));
  ////
  static String nairaSymbol = "₦";

  static String profile =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  static Widget gap({double width = 0, double height = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static List<String> validStatuses = ['pending', 'accepted', 'declined'];
  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // data being hashed

    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  static String formatTimestamp(DateTime timestamp) {
    final DateFormat formatter = DateFormat('MMMM yyyy, EEEE, \'at\' hh:mm a');
    return formatter.format(timestamp);
  }

  static String formatTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('h:mm a'); // 'a' for AM/PM
    return formatter.format(dateTime);
  }

  static List<String> genders = ["Male", "Female"];

  static String generateUUID() {
    var uuid = Uuid();
    return uuid.v4(); // Generates a version 4 (random) UUID
  }

  static Map<String, String> bloodTypeMap = {
    'APositive': 'A+',
    'ANegative': 'A-',
    'BPositive': 'B+',
    'BNegative': 'B-',
    'ABPositive': 'AB+',
    'ABNegative': 'AB-',
    'OPositive': 'O+',
    'ONegative': 'O-',
  };
}

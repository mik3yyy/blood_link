import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/main_screens/donor_main_screens/request_screen/request_successful.dart';
import 'package:blood_link/models/request.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_link/models/bloodType.dart';
import 'package:blood_link/models/inventory.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../donate_screen/find_banks.dart'; // Replace with your actual import path

class RequestFunction {
  static Future<List<DocumentSnapshot>> filterBanksByBloodAvailability(
      List<DocumentSnapshot> bankDocs,
      int pintsNeeded,
      String bloodTypeName) async {
    List<DocumentSnapshot> filteredBanks = [];

    for (var bankDoc in bankDocs) {
      // Get bankId from each bank document
      String bankId = bankDoc['bankId'];

      // Fetch the corresponding inventory document using a query
      QuerySnapshot inventoryQuery = await FirebaseFirestore.instance
          .collection('inventory')
          .where('bankId', isEqualTo: bankId)
          .limit(1)
          .get();

      if (inventoryQuery.docs.isEmpty) continue;
      DocumentSnapshot inventoryDoc = inventoryQuery.docs.first;

      // Create an Inventory object from the document
      Inventory inventory =
          Inventory.fromJson(inventoryDoc.data() as Map<String, dynamic>);

      // Check if the required blood type has enough pints
      if (doesInventoryMeetRequirement(inventory, bloodTypeName, pintsNeeded)) {
        filteredBanks.add(bankDoc);
      }
    }

    return filteredBanks;
  }

  static bool doesInventoryMeetRequirement(
      Inventory inventory, String bloodTypeName, int pintsNeeded) {
    BloodType bloodType;

    switch (bloodTypeName) {
      case 'APositive':
        bloodType = inventory.aPositive;
        break;
      case 'ANegative':
        bloodType = inventory.aNegative;
        break;
      case 'BPositive':
        bloodType = inventory.bPositive;
        break;
      case 'BNegative':
        bloodType = inventory.bNegative;
        break;
      case 'ABPositive':
        bloodType = inventory.abPositive;
        break;
      case 'ABNegative':
        bloodType = inventory.abNegative;
        break;
      case 'OPositive':
        bloodType = inventory.oPositive;
        break;
      case 'ONegative':
        bloodType = inventory.oNegative;
        break;
      default:
        return false;
    }

    return bloodType.pints >= pintsNeeded;
  }

  static Future<List<DocumentSnapshot>> findNearbyAvailableBankDocuments({
    required Location myLocation,
    required double radiusInMeters,
    required int pints,
    required String bloodTypeName,
  }) async {
    // Fetch all bank documents
    QuerySnapshot allBanksSnapshot =
        await FirebaseFirestore.instance.collection('bank').get();

    // Filter the bank documents based on nearby locations
    var nearbyBankDocs = allBanksSnapshot.docs.where((bankDoc) {
      var bankData = bankDoc.data() as Map<String, dynamic>;

      var bankLocation = Location(
          latitude: double.parse(bankData['latitude']),
          longitude: double.parse(bankData['longitude']));

      return isLocationNearby([myLocation], bankLocation, radiusInMeters);
    }).toList();

    var AvailableNearLoc = await filterBanksByBloodAvailability(
        nearbyBankDocs, pints, bloodTypeName);
    return AvailableNearLoc;
  }

  static bool isLocationNearby(List<Location> locations,
      Location targetLocation, double radiusInMeters) {
    for (Location location in locations) {
      double distance = Geolocator.distanceBetween(
        location.latitude,
        location.longitude,
        targetLocation.latitude,
        targetLocation.longitude,
      );
      print(distance);

      if (distance <= radiusInMeters) {
        return true;
      }
    }
    return false;
  }

  static Future<List<DocumentSnapshot>> findAllBankDocuments() async {
    // Fetch all bank documents
    QuerySnapshot allBanksSnapshot =
        await FirebaseFirestore.instance.collection('bank').get();

    return allBanksSnapshot.docs.toList();
  }

  static Future<void> addRequestToFirestore({
    required Request request,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required BuildContext context,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Add the request to the 'Request' collection
      await firestore
          .collection('Request')
          .doc(request.requestId)
          .set(request.toMap());
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RequestSuccessfulScreen(),
        ),
      );

      print('Request added successfully');
    } catch (e) {
      Navigator.pop(context);
      MyMessageHandler.showSnackBar(scaffoldKey, "Error adding requesting");
      print('Error adding request: $e');
    }
  }
}

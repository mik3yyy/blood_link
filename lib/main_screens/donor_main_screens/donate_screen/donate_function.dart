import 'package:blood_link/main_screens/donor_main_screens/donate_screen/find_banks.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class DonateFunction {
  static Future<List<DocumentSnapshot>> findNearbyBankDocuments(
      Location myLocation, double radiusInMeters) async {
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

    return nearbyBankDocs;
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
      print(radiusInMeters);
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
}

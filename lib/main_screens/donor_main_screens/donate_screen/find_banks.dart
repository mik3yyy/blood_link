import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/main_screens/donor_main_screens/book_appointment/book_appointment_screen.dart';
import 'package:blood_link/main_screens/donor_main_screens/donate_screen/donate_function.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NearbyBanksScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String address;

  NearbyBanksScreen(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.address})
      : super(key: key);

  @override
  _NearbyBanksScreenState createState() => _NearbyBanksScreenState();
}

class _NearbyBanksScreenState extends State<NearbyBanksScreen> {
  late Location myLocation;
  bool allbanks = false;
  @override
  void initState() {
    super.initState();
    myLocation =
        Location(latitude: widget.latitude, longitude: widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Banks'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: allbanks
            ? DonateFunction.findAllBankDocuments()
            : DonateFunction.findNearbyBankDocuments(
                myLocation, 10000), // Use the actual radius you need
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No nearby banks found'));
          }

          // Build the list using the filtered bank documents
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var bankData =
                  snapshot.data![index].data() as Map<String, dynamic>;
              // Now build a list tile for each nearby bank
              return ListTile(
                onTap: () {
                  BloodBank bloodBank = BloodBank.fromMap(bankData);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BookAppointmentScreen(bank: bloodBank)));
                },
                leading: CircleAvatar(
                  radius: 35,
                  child: Center(
                    child: Text(
                      "${bankData['bankName'][0].toString().toUpperCase()}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                title: Text(bankData['bankName'] ?? 'Unknown Bank'),
                subtitle: Text(bankData['address']),
                // Add more styling and layout as per the design in the provided image
              );
            },
          );
        },
      ),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Location &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}

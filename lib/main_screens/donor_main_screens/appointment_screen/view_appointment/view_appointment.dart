import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/main_screens/donor_main_screens/appointment_screen/view_appointment/edit_appointment.dart';
import 'package:blood_link/main_screens/donor_main_screens/appointment_screen/view_appointment/view_map.dart';
import 'package:blood_link/models/appointment.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class ViewAppointmentScreen extends StatefulWidget {
  const ViewAppointmentScreen({super.key, required this.appointment});
  final Appointment appointment;
  @override
  State<ViewAppointmentScreen> createState() => _ViewAppointmentScreenState();
}

class _ViewAppointmentScreenState extends State<ViewAppointmentScreen> {
  late LocationPermission permission;
  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      placemarks.forEach((place) {
        print(
            '${place.street}, ${place.subLocality},  ${place.subAdministrativeArea}, ${place.postalCode}');
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> bankStream = FirebaseFirestore.instance
        .collection('bank') // Ensure this is the correct collection name
        .where('bankId',
            isEqualTo: widget.appointment.bankId) // Match against the bankId
        .limit(1) // We only need the first matching document
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: bankStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Bank not found'));
          }

          // Extract the first document from the QuerySnapshot
          DocumentSnapshot bankDoc = snapshot.data!.docs.first;
          BloodBank bankData =
              BloodBank.fromMap(bankDoc.data() as Map<String, dynamic>);
          // bankDoc.data() as Map<String, dynamic>;

          // Now use the bankData to build your widget
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: Column(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Constants.black,
                      radius: 45,
                      child: Text(
                        bankData.bankName[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 40,
                          color: Constants.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Constants.Montserrat.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(
                            text: 'Your appointment with ',
                            style: Constants.Montserrat.copyWith(
                              color: Constants.black,
                            ),
                          ),
                          TextSpan(
                            text: bankData.bankName,
                            style: Constants.Montserrat.copyWith(
                              color: Constants.darkPink,
                            ),
                          ),
                          TextSpan(
                            text: " has been scheduled",
                            style: Constants.Montserrat.copyWith(
                              color: Constants.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '${Constants.formatTimestamp(widget.appointment.timestamp.toDate())}, ${bankData.address}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF667085),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Constants.gap(height: 20),
                Column(
                  children: [
                    ListTile(
                      onTap: () async {
                        try {
                          permission = await Geolocator.checkPermission();
                          if (permission == LocationPermission.denied) {
                            permission = await Geolocator.requestPermission();
                            if (permission == LocationPermission.denied) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Location permissions are denied')));
                            } else {
                              // Position position =
                              //     await Geolocator.getCurrentPosition(
                              //         desiredAccuracy: LocationAccuracy.high);
                              // print(position);
                              Position position =
                                  await Geolocator.getCurrentPosition(
                                      forceAndroidLocationManager: true,
                                      desiredAccuracy: LocationAccuracy.best);
                              print(position.latitude);
                              print(position.longitude);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewMap(
                                            bank: bankData,
                                            lat: position.latitude,
                                            long: position.longitude,
                                          )));
                            }
                          } else {
                            Position position =
                                await Geolocator.getCurrentPosition(
                                    forceAndroidLocationManager: true,
                                    desiredAccuracy: LocationAccuracy.best);

                            // await _getAddressFromLatLng(position);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewMap(
                                          bank: bankData,
                                          lat: position.latitude,
                                          long: position.longitude,
                                        )));
                          }
                        } catch (e) {}
                      },
                      leading: Container(
                        width: 40,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFEBE9FE),
                          radius: 30,
                          child: Icon(
                            Icons.map,
                            color: Color(0xFF7F56D9),
                          ),
                        ),
                      ),
                      title: Text("Open in Maps"),
                      subtitle: Text(
                          'Explore the location and get directions with ease.'),
                      trailing: Icon(
                        Icons.chevron_right,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditAppointmentScreen(
                                    appointment: widget.appointment)));
                      },
                      leading: Container(
                        width: 40,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFD1FADF),
                          radius: 30,
                          child: Icon(
                            Icons.schedule,
                            color: Color(0xFF039855),
                          ),
                        ),
                      ),
                      title: Text("Reschedule your Appointment"),
                      subtitle: Text(
                          'Choose to reschedule your blood donation appointment.'),
                      trailing: Icon(
                        Icons.chevron_right,
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        width: 40,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFFFD1DC),
                          radius: 30,
                          child: Icon(
                            Icons.cancel_outlined,
                            color: Color(0xFFFF0012),
                          ),
                        ),
                      ),
                      title: Text("Cancel your Appointment"),
                      subtitle: Text(
                          'Opt to withdraw your blood donation appointment.'),
                      trailing: Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
      // body: ,
    );
  }
}

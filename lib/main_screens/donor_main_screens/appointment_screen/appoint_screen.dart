import 'package:blood_link/main_screens/donor_main_screens/appointment_screen/appointment_function.dart';
import 'package:blood_link/main_screens/donor_main_screens/appointment_screen/view_appointment/view_appointment.dart';
import 'package:blood_link/models/appointment.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    Stream<QuerySnapshot> appointmentStream = FirebaseFirestore.instance
        .collection('Appointments')
        .where('email', isEqualTo: authProvider.donor!.email)
        .orderBy('timestamp',
            descending: true) // Assuming 'timestamp' is the field name
        .snapshots();
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text("Appointments"),
        ),
        body: Container(
            height: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: appointmentStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Print(snapshot.error);
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                // Extracting data from snapshot
                List<DocumentSnapshot> appointments = snapshot.data!.docs;

                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    // Extract appointment data
                    var appointment =
                        appointments[index].data() as Map<String, dynamic>;

                    var status = appointment['status'] as String;
                    var timestamp = appointment['timestamp'] as Timestamp;
                    var bankId = appointment['bankId'] as String;

                    // Fetch the bank document asynchronously where 'bankId' matches
                    return FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('bank')
                          .where('bankId', isEqualTo: bankId)
                          .limit(1)
                          .get(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> bankSnapshot) {
                        if (bankSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListTile(
                            title: Text('Loading bank info...'),
                            subtitle: Text(
                                'Your appointment time is ${timestamp.toDate()}'),
                          );
                        }

                        if (bankSnapshot.hasError) {
                          return ListTile(
                            title: Text('Error loading bank info'),
                            subtitle: Text(
                                'Your appointment time is ${timestamp.toDate()}'),
                          );
                        }

                        if (!bankSnapshot.hasData ||
                            bankSnapshot.data!.docs.isEmpty) {
                          return ListTile(
                            title: Text('Bank info not found'),
                            subtitle: Text(
                                'Your appointment time is ${timestamp.toDate()}'),
                          );
                        }

                        // Extract bank name
                        String bankName =
                            bankSnapshot.data!.docs.first['bankName'];

                        // Now return the ListTile with the bank name
                        return ListTile(
                          onTap: () {
                            Appointment main = Appointment.fromMap(appointment);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAppointmentScreen(
                                          appointment: main,
                                        )));
                          },
                          leading: Container(
                            width: 40,
                            child: CircleAvatar(
                              backgroundColor: Constants.black,
                              radius: 30,
                              child: Text(
                                bankName[0].toUpperCase(),
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Constants.white,
                                ),
                              ),
                            ),
                          ),
                          title: Text('$bankName'),
                          subtitle: Text(
                            '${Constants.formatTimestamp(timestamp.toDate())}',
                            style: TextStyle(fontSize: 12),
                          ),
                          trailing: status == 'pending'
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.close_sharp,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      onPressed: () async {
                                        Appointment appointmentNew =
                                            Appointment.fromMap(appointment);
                                        await AppointmentFunction
                                            .updateFirstAppointmentStatusByEmail(
                                                appointment: appointmentNew,
                                                newStatus:
                                                    Constants.validStatuses[2],
                                                scaffoldKey: scaffoldKey);
                                        // Handle cancel action
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () async {
                                        Appointment appointmentNew =
                                            Appointment.fromMap(appointment);
                                        await AppointmentFunction
                                            .updateFirstAppointmentStatusByEmail(
                                                appointment: appointmentNew,
                                                newStatus:
                                                    Constants.validStatuses[1],
                                                scaffoldKey: scaffoldKey);
                                        setState(() {});
                                        // Handle confirm action
                                      },
                                    ),
                                  ],
                                )
                              : IconButton(
                                  icon: Icon(Icons.settings),
                                  onPressed: () {
                                    Appointment main =
                                        Appointment.fromMap(appointment);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewAppointmentScreen(
                                                  appointment: main,
                                                )));
                                    // Handle settings action
                                  },
                                ),
                        );
                      },
                    );
                  },
                );
              },
            )),
      ),
    );
  }
}

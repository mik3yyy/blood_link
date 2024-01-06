import 'package:blood_link/global_comonents/custom_text_button.dart';
import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/main_screens/donor_main_screens/book_appointment/book_appointment_screen.dart';
import 'package:blood_link/main_screens/donor_main_screens/donate_screen/donate_function.dart';
import 'package:blood_link/main_screens/donor_main_screens/donate_screen/find_banks.dart';
import 'package:blood_link/main_screens/donor_main_screens/request_screen/request_function.dart';
import 'package:blood_link/models/request.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_home_screen/bank_main_function.dart';
import 'package:blood_link/models/bloodType.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailableNearbyBanksScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String address;
  final int pints;
  final String bloodType;

  AvailableNearbyBanksScreen(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.bloodType,
      required this.pints})
      : super(key: key);

  @override
  _AvailableNearbyBanksScreenState createState() =>
      _AvailableNearbyBanksScreenState();
}

class _AvailableNearbyBanksScreenState
    extends State<AvailableNearbyBanksScreen> {
  late Location myLocation;
  bool allbanks = false;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    myLocation =
        Location(latitude: widget.latitude, longitude: widget.longitude);
  }

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Builder(builder: (context) {
      return ScaffoldMessenger(
        key: scaffoldKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Nearby Banks'),
          ),
          body: FutureBuilder<List<DocumentSnapshot>>(
            future: allbanks
                ? DonateFunction.findAllBankDocuments()
                : RequestFunction.findNearbyAvailableBankDocuments(
                    myLocation: myLocation,
                    radiusInMeters: 1000,
                    pints: widget.pints,
                    bloodTypeName: widget.bloodType,
                  ), // Use the actual radius you need
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
                  return Container(
                    height: 100,
                    child: ListTile(
                      onTap: () async {
                        BloodBank bloodBank = BloodBank.fromMap(bankData);

                        await showDialog<void>(
                          context: context,
                          builder: (context) => ConfirmPopup(
                            body: "Please confirm request",
                            loading: loading,
                            onAction: () async {
                              Request request = Request(
                                requestId: Constants.generateUUID(),
                                status: Constants.validStatuses[0],
                                bankId: bloodBank.bankId,
                                email: authProvider.donor!.email,
                                address: widget.address,
                                pints: widget.pints,
                                bloodType:
                                    Constants.bloodTypeMap[widget.bloodType]!,
                              );
                              setState(() {
                                loading = true;
                              });
                              await RequestFunction.addRequestToFirestore(
                                request: request,
                                scaffoldKey: scaffoldKey,
                                context: context,
                              );
                              setState(() {
                                loading = false;
                              });
                            },
                            onCancel: () {
                              Navigator.pop(context);
                            },
                            title:
                                "Are you sure you want to request from ${bloodBank.bankName}",
                            actionText: "Request",
                          ),
                        );

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             BookAppointmentScreen(bank: bloodBank)));
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
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    });
  }
}

// class Location {
//   final double latitude;
//   final double longitude;

//   Location({required this.latitude, required this.longitude});

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Location &&
//         other.latitude == latitude &&
//         other.longitude == longitude;
//   }

//   @override
//   int get hashCode => latitude.hashCode ^ longitude.hashCode;
// }

class ConfirmPopup extends StatefulWidget {
  const ConfirmPopup({
    super.key,
    required this.body,
    required this.loading,
    required this.onAction,
    required this.onCancel,
    required this.title,
    required this.actionText,
    this.cancelText = "cancel",
  });
  final String title;
  final String body;
  final String actionText;
  final String cancelText;
  final bool loading;
  final Function() onAction;
  final Function() onCancel;

  @override
  State<ConfirmPopup> createState() => _ConfirmPopupState();
}

class _ConfirmPopupState extends State<ConfirmPopup> {
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40,
            top: -40,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                backgroundColor: Constants.white,
                child: Icon(
                  Icons.close,
                  color: Constants.darkPink,
                ),
              ),
            ),
          ),
          Container(
            height: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.body,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Constants.grey),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextButton(
                        text: widget.cancelText!,
                        color: Constants.darkPink,
                        onPressed: widget.onCancel,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        loading: widget.loading,
                        onTap: widget.onAction,
                        title: widget.actionText,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

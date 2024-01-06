import 'dart:math';

import 'package:blood_link/global_comonents/custom_list_container.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_drawer.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_order_screen/view_order.dart';
import 'package:blood_link/models/request.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankOrderScreen extends StatefulWidget {
  const BankOrderScreen({super.key});
  static String id = "/bank_order_screen";

  @override
  State<BankOrderScreen> createState() => _BankOrderScreenState();
}

class _BankOrderScreenState extends State<BankOrderScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);

    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        key: _key, // Assign the key to Scaffold.
        drawer: BankDrawer(),
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Orders",
            style: TextStyle(
              color: Constants.white,
            ),
          ),
          backgroundColor: Constants.darkPink,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Constants.white,
            ),
            onPressed: () {
              // Scaffold.of(context).openDrawer();
              _key.currentState!.openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Name",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Quantity",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Group",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Request')
                      .where('bankId', isEqualTo: authProvider.bank!.bankId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Text('No data available'));
                    }

                    // Filter requests with status 'accepted'
                    List<DocumentSnapshot> acceptedRequests = snapshot
                        .data!.docs
                        .where((doc) => doc['status'] == 'pending')
                        .toList();

                    return ListView.builder(
                      itemCount: acceptedRequests.length,
                      itemBuilder: (context, index) {
                        // Query for the donor with the specific email
                        Stream<QuerySnapshot> donorStream = FirebaseFirestore
                            .instance
                            .collection('donor')
                            .where('email',
                                isEqualTo: snapshot.data!.docs[index]["email"])
                            .limit(1)
                            .snapshots();

                        var requests = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;

                        // Formatting the timestamp to a readable format
                        // Assumes 'timestamp' is stored as a Timestamp in Firestore
                        // DateTime dateTime =
                        //     (appointment['timestamp'] as Timestamp).toDate();
                        // String formattedDate =
                        //     "${dateTime.hour}:${dateTime.minute}";
                        // formattedDate = Constants.formatTime(dateTime);

                        return StreamBuilder<QuerySnapshot>(
                          stream: donorStream,
                          builder: (context, donorSnapshot) {
                            if (donorSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ListTile(
                                title: Text('Loading donor...'),
                              );
                            }
                            if (donorSnapshot.hasError) {
                              return const ListTile(
                                title: Text('Error loading donor'),
                              );
                            }
                            if (!donorSnapshot.hasData ||
                                donorSnapshot.data!.docs.isEmpty) {
                              return const ListTile(
                                title: Text('Donor not found'),
                              );
                            }

                            // Extract the first (and should be the only) donor document
                            var donorData = donorSnapshot.data!.docs.first
                                .data() as Map<String, dynamic>;

                            Donor donor = Donor.fromMap(donorData);

                            // Display the donor details
                            return GestureDetector(
                              onTap: () {
                                Request request = Request.fromMap(
                                    acceptedRequests[index].data()
                                        as Map<String, dynamic>);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewOrderDetails(
                                              donor: donor,
                                              request: request,
                                            )));
                              },
                              child: CustomListContainer(
                                index: index,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${donor.lastName} ${donor.firstName}",
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(acceptedRequests[index]
                                              ['pints']
                                          .toString()),
                                    ),
                                    Expanded(
                                      child: Text(
                                        acceptedRequests[index]['bloodType'],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                    //         ListView.builder(
                    //   itemCount: acceptedRequests.length,
                    //   itemBuilder: (context, index) {
                    //     var requestData = acceptedRequests[index].data()
                    //         as Map<String, dynamic>;
                    //     Request request = Request.fromMap(requestData);
                    //     return Row(
                    //       children: [
                    //         Expanded(
                    //           child: Text((index + 1).toString()),
                    //         ),
                    //         Expanded(
                    //           flex: 2,
                    //           child: Text(
                    //             request.email,
                    //             style: TextStyle(fontSize: 12),
                    //           ),
                    //         ),
                    //         Expanded(
                    //           child: Text(request.bloodType),
                    //         ),
                    //         Expanded(
                    //           child: Text(request.pints.toString()),
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

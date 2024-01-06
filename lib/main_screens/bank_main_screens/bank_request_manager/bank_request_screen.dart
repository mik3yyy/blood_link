import 'package:blood_link/global_comonents/custom_list_container.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_request_manager/request_donor.dart';
import 'package:flutter/material.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_drawer.dart';
import 'package:blood_link/models/appointment.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BankRequestManager extends StatefulWidget {
  const BankRequestManager({super.key});
  static String id = "/bank_request";
  @override
  State<BankRequestManager> createState() => _BankRequestManagerState();
}

class _BankRequestManagerState extends State<BankRequestManager> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  PageController _pageController = PageController();

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
            "Request Manager",
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
        body: Column(
          children: [
            Container(
              // height: 40,
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              color: Constants.darkPink,
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: Column(
                      children: [
                        Text(
                          'Donors',
                          style: TextStyle(
                            color: Constants.white,
                          ),
                        ),
                        // if (_pageController.page == 0)
                      ],
                    ),
                  )),
                  Constants.gap(width: 20),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: Column(
                      children: [
                        Text(
                          'Requests',
                          style: TextStyle(
                            color: Constants.white,
                          ),
                        ),
                        // if (_pageController.page == 1)
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Container(
              height: 10,
              // padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              color: Constants.darkPink,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 2,
                effect: WormEffect(
                  activeDotColor: Constants.white,
                  dotColor: Constants.darkPink,
                  dotHeight: 10,
                  dotWidth: MediaQuery.sizeOf(context).width * 0.5,
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  Column(
                    children: [
                      CustomListContainer(
                        index: 1,
                        child: const Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Gender",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Blood Type",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Appointments')
                              .where('bankId',
                                  isEqualTo: authProvider.bank!.bankId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text('No appointments available'));
                            }

                            // Extract unique emails
                            var uniqueEmails = snapshot.data!.docs
                                .map((doc) => doc['email'] as String)
                                .toSet()
                                .toList();

                            return ListView.builder(
                              itemCount: uniqueEmails.length,
                              itemBuilder: (context, index) {
                                // Query for the donor with the specific email
                                Stream<QuerySnapshot> donorStream =
                                    FirebaseFirestore.instance
                                        .collection('donor')
                                        .where('email',
                                            isEqualTo: uniqueEmails[index])
                                        .limit(1)
                                        .snapshots();

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
                                    var donorData =
                                        donorSnapshot.data!.docs.first.data()
                                            as Map<String, dynamic>;

                                    Donor donor = Donor.fromMap(donorData);
                                    // Display the donor details
                                    return CustomListContainer(
                                      index: index,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RequestDonor(
                                                          donor: donor)));
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "${donor.lastName} ${donor.firstName}",
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                donor.gender,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                donor.bloodType,
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
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomListContainer(
                        index: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                            // Expanded(
                            //   child: Text(
                            //     "Status",
                            //     style: TextStyle(
                            //         fontSize: 14, fontWeight: FontWeight.w600),
                            //   ),
                            // ),
                            Expanded(
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  padding: EdgeInsets.all(2),
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Constants.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text("Status"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Appointments')
                              .where('bankId',
                                  isEqualTo: authProvider.bank!.bankId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text('No appointments available'));
                            }

                            // Extract unique emails
                            // var uniqueEmails = snapshot.data!.docs.map((doc) {
                            //   Print(doc.data());
                            //   // doc['note'] as String;
                            // }).toList();
                            // Print(uniqueEmails);

                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                // Query for the donor with the specific email
                                Stream<QuerySnapshot> donorStream =
                                    FirebaseFirestore.instance
                                        .collection('donor')
                                        .where('email',
                                            isEqualTo: snapshot
                                                .data!.docs[index]["email"])
                                        .limit(1)
                                        .snapshots();

                                var appointment = snapshot.data!.docs[index]
                                    .data() as Map<String, dynamic>;
                                // Formatting the timestamp to a readable format
                                // Assumes 'timestamp' is stored as a Timestamp in Firestore
                                DateTime dateTime =
                                    (appointment['timestamp'] as Timestamp)
                                        .toDate();
                                String formattedDate =
                                    "${dateTime.hour}:${dateTime.minute}";
                                formattedDate = Constants.formatTime(dateTime);

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
                                    var donorData =
                                        donorSnapshot.data!.docs.first.data()
                                            as Map<String, dynamic>;

                                    Donor donor = Donor.fromMap(donorData);
                                    // Display the donor details
                                    return CustomListContainer(
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
                                            child: Center(
                                              child: Container(
                                                margin: EdgeInsets.all(2),
                                                padding: EdgeInsets.all(2),
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Constants.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    appointment['status']
                                                        .toString()
                                                        .toLowerCase(),
                                                    style: TextStyle(
                                                      color: appointment[
                                                                  'status'] ==
                                                              Constants
                                                                      .validStatuses[
                                                                  0]
                                                          ? Color(0xFFF3C110)
                                                          : appointment[
                                                                      'status'] ==
                                                                  Constants
                                                                          .validStatuses[
                                                                      1]
                                                              ? Color(
                                                                  0xFF72C8CC)
                                                              : Color(
                                                                  0xFFE53E3E),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

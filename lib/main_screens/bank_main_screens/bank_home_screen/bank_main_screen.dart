import 'package:blood_link/authentication/bloodBank_login_screen/login_function.dart';
import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_inventory_popup.dart';
import 'package:blood_link/global_comonents/custom_list_container.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_drawer.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_home_screen/bank_main_function.dart';
import 'package:blood_link/models/bloodType.dart';
import 'package:blood_link/models/inventory.dart';
import 'package:blood_link/models/request.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/Blood.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BankMainScreen extends StatefulWidget {
  const BankMainScreen({super.key});
  static String id = '/bank_main';

  @override
  State<BankMainScreen> createState() => _BankMainScreenState();
}

class _BankMainScreenState extends State<BankMainScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var bank = authProvider.bank!;
    BloodBankMainFunction.bankReload(
      email: bank.email,
      password: bank.password,
      scaffoldKey: scaffoldKey,
      context: context,
    );
    // BloodLoginFunction.bloodLogin(
    //     email: authProvider.bank!.email,
    //     password: (authProvider.bank!.password),
    //     scaffoldKey: scaffoldKey,
    //     hashed: true,
    //     context: context);
  }

  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        key: _key, // Assign the key to Scaffold.
        drawer: BankDrawer(),
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Welcome ${authProvider.bank!.bankName}",
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
              height: 200,
              padding: EdgeInsets.all(20),
              width: double.infinity,
              color: Constants.darkPink,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('inventory')
                              .doc(authProvider.bank!.bankId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData) {
                              return Center(
                                  child: Text(
                                      'No inventory found for bank ID: ${authProvider.bank!.bankId}'));
                            }

                            var data =
                                snapshot.data!.data() as Map<String, dynamic>?;

                            if (data == null) {
                              return Center(
                                  child:
                                      Text('Inventory data is not available'));
                            }

                            int totalPints = data.entries
                                .where((entry) =>
                                    entry.key.endsWith('Positive') ||
                                    entry.key.endsWith('Negative'))
                                .fold(
                                    0,
                                    (sum, entry) => int.parse(
                                        (sum + entry.value['pints'])
                                            .toString()));

                            return Column(
                              children: [
                                Text(
                                  "Total Pints",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Constants.white),
                                ),
                                Text(
                                  "${totalPints}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Constants.white,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Request')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData) {
                              return Center(child: Text('No data found'));
                            }

                            // Calculate the total number of banks
                            int totalBanks = snapshot.data!.docs.length;

                            // Display the total number of banks
                            return Column(
                              children: [
                                Text(
                                  "Total Orders",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Constants.white),
                                ),
                                Text(
                                  "${totalBanks}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Constants.white,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Request')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData) {
                              return Center(child: Text('No data found'));
                            }

                            // Calculate the total number of banks
                            var docs = snapshot.data!.docs.toList().where(
                                (element) => element['status'] == "accepted");
                            int totalBanks = docs.length;

                            // Display the total number of banks
                            return Column(
                              children: [
                                Text(
                                  "Completed Orders",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Constants.white),
                                ),
                                Text(
                                  "${totalBanks}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Constants.white,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
                          'Inventory',
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
                          'Order history',
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
                StreamBuilder<DocumentSnapshot>(
                  // Listen to a specific document in a collection
                  stream: FirebaseFirestore.instance
                      .collection('inventory')
                      .doc(authProvider.bank!.bankId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading indicator while waiting for stream data
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Handle any errors from Firebase
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data!.exists) {
                      // Build UI based on the data from the Firestore document
                      var docData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      Inventory inventory = Inventory.fromJson(docData);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 10),
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      2, // Adjust the number of items per row
                                  crossAxisSpacing: 10, // Spacing between items
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 70),
                          children: [
                            CustomBloodType(
                              bloodtype: inventory.aPositive,
                            ),
                            CustomBloodType(
                              bloodtype: inventory.aNegative,
                            ),
                            CustomBloodType(
                              bloodtype: inventory.bPositive,
                            ),
                            CustomBloodType(
                              bloodtype: inventory.bNegative,
                            ),
                            CustomBloodType(
                              bloodtype: inventory.abPositive,
                            ),
                            CustomBloodType(
                              bloodtype: inventory.abNegative,
                            ),
                            CustomBloodType(
                              bloodtype: inventory.oPositive,
                            ),
                            CustomBloodType(
                              bloodtype: inventory.oNegative,
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Handle the case where the document does not exist
                      return Center(child: Text('Document does not exist.'));
                    }
                  },
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "#",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Type",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "pints",
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
                            .collection('Request')
                            .where('bankId',
                                isEqualTo: authProvider.bank!.bankId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }
                          if (!snapshot.hasData) {
                            return Center(child: Text('No data available'));
                          }

                          // Filter requests with status 'accepted'
                          List<DocumentSnapshot> acceptedRequests = snapshot
                              .data!.docs
                              .where((doc) => doc['status'] == 'accepted')
                              .toList();

                          return ListView.builder(
                            itemCount: acceptedRequests.length,
                            itemBuilder: (context, index) {
                              var requestData = acceptedRequests[index].data()
                                  as Map<String, dynamic>;
                              Request request = Request.fromMap(requestData);
                              return CustomListContainer(
                                index: index,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text((index + 1).toString()),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        request.email,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                          child: Text(request.bloodType)),
                                    ),
                                    Expanded(
                                      child: Text(request.pints.toString()),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class CustomBloodType extends StatelessWidget {
  const CustomBloodType({super.key, required this.bloodtype});
  final BloodType bloodtype;
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () async {
        await showDialog<void>(
            context: context,
            builder: (context) => InventoryPopup(
                  bloodType: bloodtype,
                ));
      },
      child: Container(
        height: 70,
        child: Row(
          children: [
            Container(
              height: 70,
              width: 5,
              color: Constants.darkPink,
            ),
            Container(
              height: 70,
              width: 160,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bloodtype.symbol,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Constants.Montserrat.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '${Constants.nairaSymbol} ${bloodtype.unit}',
                              style: Constants.Montserrat.copyWith(
                                color: Constants.darkPink,
                              ),
                            ),
                            TextSpan(
                              text: '/unit',
                              style: Constants.Montserrat.copyWith(
                                color: Constants.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text("${bloodtype.pints} pints"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

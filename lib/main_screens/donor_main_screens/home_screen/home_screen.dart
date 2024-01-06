import 'package:blood_link/main_screens/donor_main_screens/home_screen/view_campaign.dart';
import 'package:blood_link/models/campaign.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
              ),
              Text(
                "GIVE THE GIFT OF LIFE",
                style: Constants.Montserrat.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
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
                      text: 'Donate',
                      style: Constants.Montserrat.copyWith(
                          color: Constants.darkPink,
                          fontWeight: FontWeight.w400,
                          fontSize: 36),
                    ),
                    TextSpan(
                      text: ' Blood',
                      style: Constants.Montserrat.copyWith(
                          color: Constants.darkPink,
                          fontWeight: FontWeight.w900,
                          fontSize: 36),
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Constants.Montserrat.copyWith(
                      fontWeight: FontWeight.w400, color: Constants.black),
                  children: [
                    TextSpan(
                      text: 'Each Donations can help save up to',
                      style: Constants.Montserrat.copyWith(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    TextSpan(
                      text: '  3 lives!',
                      style: Constants.Montserrat.copyWith(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Constants.gap(height: 20),
              Container(
                height: 200,
                width: MediaQuery.sizeOf(context).width,
                child: Image.asset(
                  "assets/images/donor_main_screen/graph.jpg",
                  fit: BoxFit.fill,
                  // height: 3409,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Campaigns and Articles',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                // Replace with your collection name
                stream: FirebaseFirestore.instance
                    .collection('campaigns')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final campaigns = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: campaigns.length,
                    itemBuilder: (context, index) {
                      var campaign =
                          campaigns[index].data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewCampaign(
                                  campaign: Campaign.fromMap(campaign)),
                            ),
                          );
                        },
                        child: Card(
                          // Adjust the styling as needed
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.network(
                                campaign['image'],
                                fit: BoxFit.cover,
                                // Adjust the height as needed, or make it responsive
                                height: 200,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  campaign['campaignTitle'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:blood_link/main_screens/bank_main_screens/bank_campaign_screen/bank_campaign_screen.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_donor_manager_screen/bank_donor_manager_screen.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_home_screen/bank_main_screen.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_order_screen/bank_order_screen.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_profile_screen/bank_profile.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_request_manager/bank_request_screen.dart';
import 'package:blood_link/onboarding/onboarding.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankDrawer extends StatefulWidget {
  const BankDrawer({super.key});

  @override
  State<BankDrawer> createState() => _BankDrawerState();
}

class _BankDrawerState extends State<BankDrawer> {
  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constants.gap(height: 50),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Constants.darkPink,
                  radius: 45,
                  child: Text(
                    authProvider.bank!.bankName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 40,
                      color: Constants.white,
                    ),
                  ),
                ),
                Constants.gap(height: 20),
                Text(
                  authProvider.bank!.bankName,
                  style: TextStyle(
                    color: Constants.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Constants.gap(height: 10),
                Text(
                  authProvider.bank!.address,
                  style: TextStyle(
                    color: Constants.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Constants.darkPink,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, BankMainScreen.id);
                        },
                        leading: Icon(
                          Icons.home,
                          color: Constants.white,
                        ),
                        title: Text(
                          'Home',
                          style: TextStyle(color: Constants.white),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Constants.white,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, BankDonorManagerScreen.id);
                        },
                        leading: Icon(
                          Icons.group,
                          color: Constants.white,
                        ),
                        title: Text(
                          'Donor Manager',
                          style: TextStyle(color: Constants.white),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Constants.white,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, BankRequestManager.id);
                        },
                        leading: Icon(
                          Icons.search,
                          color: Constants.white,
                        ),
                        title: Text(
                          'Blood Request',
                          style: TextStyle(color: Constants.white),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Constants.white,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, BankOrderScreen.id);
                        },
                        leading: Icon(
                          Icons.checklist,
                          color: Constants.white,
                        ),
                        title: Text(
                          'Orders',
                          style: TextStyle(color: Constants.white),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Constants.white,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, BankCampaign.id);
                        },
                        leading: Icon(
                          Icons.speaker_group_outlined,
                          color: Constants.white,
                        ),
                        title: Text(
                          'Campaign',
                          style: TextStyle(color: Constants.white),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Constants.white,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, BankProfileScreen.id);
                        },
                        leading: Icon(
                          Icons.person,
                          color: Constants.white,
                        ),
                        title: Text(
                          'Profile',
                          style: TextStyle(color: Constants.white),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Constants.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.white,
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, OnboardingScreen.id, (route) => false);
                          authProvider.clearData();
                        },
                        leading: Icon(
                          Icons.logout,
                          color: Constants.darkPink,
                        ),
                        textColor: Constants.darkPink,
                        // co
                        title: Text("Logout"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

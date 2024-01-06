import 'package:blood_link/global_comonents/custom_button_tile.dart';
import 'package:blood_link/main_screens/donor_main_screens/profile_screen/change_password/change_password.dart';
import 'package:blood_link/main_screens/donor_main_screens/profile_screen/edit_profile/edit_profile_screen.dart';
import 'package:blood_link/onboarding/onboarding-option.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ButtonTile(
                  leading: Icon(Icons.person),
                  title: "Account Settings",
                  traling: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                ),
                ButtonTile(
                  leading: Icon(Icons.lock),
                  title: "Change Password",
                  traling: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Changepassword(donor: authProvider.donor!)));
                  },
                ),
                ButtonTile(
                  leading: Icon(Icons.delete),
                  title: "Delete Account",
                  traling: Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
            ButtonTile(
              leading: Icon(
                Icons.logout,
                color: Constants.white,
              ),
              color: Constants.darkPink,
              title: "Log out",
              onTap: () async {
                await Navigator.pushNamedAndRemoveUntil(
                        context, OnboardingOption.id, (route) => false)
                    .then((value) => authProvider.clearData());
              },
            ),
          ],
        ),
      ),
    );
  }
}

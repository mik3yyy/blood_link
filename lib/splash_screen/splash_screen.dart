import 'package:blood_link/main_screens/bank_main_screens/bank_home_screen/bank_main_screen.dart';
import 'package:blood_link/main_screens/donor_main_screens/donor_main_screen.dart';
import 'package:blood_link/onboarding/onboarding.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = "/splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loadScreen = false;

  // init(BuildContext context) async {
  //   Future.delayed(Duration(seconds: 4), () async {
  //     var box = await Hive.openBox<Donor>('donorBox');
  //   });
  // }

  void splash(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {}).then((value) {
      // Navigator.pushNamed(context, OnboardingScreen.id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // HiveFunction.deleteToken();
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var donorBox = Hive.box('donorBox');
    var bankBox = Hive.box('bankBox');

    Future.delayed(Duration(seconds: 2), () async {
      var donor = await donorBox.get('donorKey');
      var bank = await bankBox.get('bankKey');

      if (donor != null) {
        authProvider.saveDonor(donor);
        Navigator.pushNamed(context, DonorMainScreen.id);
      } else if (bank != null) {
        authProvider.saveBank(bank);
        Navigator.pushNamed(context, BankMainScreen.id);
      } else {
        Navigator.pushNamed(context, OnboardingScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.darkPink,
      body: Center(
        child: Image.asset("assets/images/onboarding/splash.png"),
      ),
    );
  }
}

import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_home_screen/bank_main_screen.dart';
import 'package:blood_link/main_screens/donor_main_screens/donor_main_screen.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentSuccess extends StatefulWidget {
  const AppointmentSuccess({super.key});

  @override
  State<AppointmentSuccess> createState() => _AppointmentSuccessState();
}

class _AppointmentSuccessState extends State<AppointmentSuccess> {
  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/donor_main_screen/success_img.png"),
            Constants.gap(height: 10),
            Text(
              "Appointment Booked successfully",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            Constants.gap(height: 10),
            Text(
              "Thank you for scheduling your appointment. We look forward to seeing you. For any changes, please contact us.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Constants.grey,
              ),
            ),
            Constants.gap(height: 10),
            CustomButton(
              onTap: () {
                if (authProvider.bank == null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, DonorMainScreen.id, (route) => false);
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context, BankMainScreen.id, (route) => false);
                }
              },
              title: "Return Home",
              width: MediaQuery.sizeOf(context).width * 0.4,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:blood_link/global_comonents/custom_text_button.dart';
import 'package:blood_link/main_screens/donor_main_screens/donor_main_screen.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';

class RequestSuccessfulScreen extends StatefulWidget {
  const RequestSuccessfulScreen({super.key});

  @override
  State<RequestSuccessfulScreen> createState() =>
      _RequestSuccessfulScreenState();
}

class _RequestSuccessfulScreenState extends State<RequestSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            height: 330,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/donor_main_screen/request_successful.png",
                ),
                Text(
                  "Order Created",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Your order has been successfully created. You will receive a notification once it is approved.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    CustomTextButton(
                      text: "Return to home",
                      color: Constants.darkPink,
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, DonorMainScreen.id, (route) => false);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

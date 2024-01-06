import 'package:blood_link/authentication/bloodBank_login_screen/login_screen.dart';
import 'package:blood_link/authentication/login_screen/login_screen.dart';
import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_text_button.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingOption extends StatefulWidget {
  const OnboardingOption({super.key});
  static String id = "/onboard-option";
  @override
  State<OnboardingOption> createState() => _OnboardingOptionState();
}

class _OnboardingOptionState extends State<OnboardingOption> {
  PageController _pageController = PageController(initialPage: 0);
  PageController _pageController2 = PageController(initialPage: 0);
  int _currentIndex = 0;
  List<Map<String, String>> onboarding = [
    {
      "title": "Discover Nearby Blood Banks",
      "body":
          "Easily locate and connect with blood banks in your vicinity for donations or blood retrieval.",
    },
    {
      "title": "Join as a Blood Bank",
      "body":
          "Register your blood bank to manage donations, update inventory, and connect with donors and recipients."
    },
  ];
  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: (val) {
                    _pageController2.jumpToPage(val);
                    setState(() {
                      _currentIndex = val;
                    });
                  },
                  controller: _pageController,
                  children: [
                    Image.asset('assets/images/onboarding/image-4.png'),
                    Image.asset('assets/images/onboarding/image-5.png'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: 2,
                              effect: WormEffect(
                                activeDotColor: Constants.black,
                                dotHeight: 10,
                                dotWidth: 10,
                              ),
                            ),
                          ]),
                    ),
                    Expanded(
                      child: PageView.builder(
                        itemCount: 2,
                        controller: _pageController2,
                        onPageChanged: (value) {
                          _pageController.jumpToPage(value);
                          setState(() {
                            _currentIndex = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                onboarding[index]["title"]!,
                                textAlign: TextAlign.center,
                                style: Constants.Montserrat.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Constants.gap(height: 15),
                              Text(
                                onboarding[index]["body"]!,
                                textAlign: TextAlign.center,
                                style: Constants.Montserrat.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                child: Column(
                  children: [
                    CustomButton(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        title: "Donor"),
                    Constants.gap(height: 20),
                    CustomButtonSecondary(
                      onTap: () {
                        Navigator.pushNamed(context, BloodBankLoginScreen.id);
                      },
                      title: "Blood Bank",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_text_button.dart';
import 'package:blood_link/onboarding/onboarding-option.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static String id = "/onboarding";
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  PageController _pageController2 = PageController(initialPage: 0);
  int _currentIndex = 0;
  List<Map<String, String>> onboarding = [
    {
      "title": "Welcome to BloodLink",
      "body":
          "BloodLink: Save lives through blood donation. Connect donors with patients in need. Real-time inventory updates. Intelligent matching algorithm. Join us now!"
    },
    {
      "title": "Find Donors and  Safe Blood Supply",
      "body":
          "Find blood donors easily with our Online Blood Bank Management System. Our vast network ensures a timely and reliable supply of blood for patients in critical need. Save lives today!"
    },
    {
      "title": "Donated Blood, Saving Lives",
      "body":
          "Your blood donation saves lives and provides a lifeline to patients in need. Thank you for your compassion and generosity during medical treatments, surgeries, and emergencies."
    }
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
                    Image.asset('assets/images/onboarding/image-1.png'),
                    Image.asset('assets/images/onboarding/image-2.png'),
                    Image.asset('assets/images/onboarding/image-3.png'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, top: 20),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SmoothPageIndicator(
                                controller: _pageController,
                                count: 3,
                                effect: WormEffect(
                                  activeDotColor: Constants.orange,
                                  dotHeight: 10,
                                  dotWidth: 10,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        itemCount: 3,
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
                                style: Constants.Montserrat.copyWith(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                onboarding[index]["body"]!,
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
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _currentIndex != 2
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossA,
                  children: [
                    Container(
                      height: 100,
                      width: 160,
                      child: CustomTextButton(
                        onPressed: () {
                          _pageController.jumpToPage(
                            2,
                          );
                          _pageController2.jumpToPage(
                            2,
                          );
                        },
                        text: "Skip",
                        // color: Constants.black,
                      ),
                    ),
                    CustomButton(
                      onTap: () {
                        setState(() {
                          _currentIndex = _currentIndex++;
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeIn);
                          _pageController2.nextPage(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeIn);
                        });
                      },
                      title: "Next",
                      width: 183,
                      color: Constants.primaryPink,
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossA,

                  children: [
                    Container(
                      height: 100,
                      width: 160,
                      child: CustomTextButton(
                        onPressed: () {},
                        text: "",
                        // color: Constants.black,
                      ),
                    ),
                    CustomButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnboardingOption()));
                      },
                      title: "Continue",
                      width: 183,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

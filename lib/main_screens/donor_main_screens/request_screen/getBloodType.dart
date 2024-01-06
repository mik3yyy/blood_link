import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/main_screens/donor_main_screens/request_screen/find_available_bank.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';

class GetBloddType extends StatefulWidget {
  const GetBloddType({
    super.key,
    required this.address,
    required this.lat,
    required this.long,
  });
  final String lat;
  final String long;
  final String address;

  @override
  State<GetBloddType> createState() => _GetBloddTypeState();
}

class _GetBloddTypeState extends State<GetBloddType> {
  final TextEditingController _qController = TextEditingController();
  int currentIndex = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _qController.text = "1";
  }

  List<String> bloodTypes = [
    "APositive",
    "ANegative",
    "BPositive",
    "BNegative",
    "ABPositive",
    "ABNegative",
    "OPositive",
    "ONegative"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.darkPink,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * .6,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * .2,
                        color: Constants.darkPink,
                        child: Column(
                          children: [
                            // Constants.gap(
                            //     height: MediaQuery.of(context).size.height * .1),
                            Text(
                              "Find Blood",
                              style: TextStyle(
                                fontSize: 36,
                                color: Constants.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: MediaQuery.sizeOf(context).width * 0.1,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        height: 450,
                        decoration: BoxDecoration(
                          color: Constants.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Blood group",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                            Constants.gap(height: 20),
                            Container(
                              height: 360,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 5),
                              child: GridView(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      3, // Adjust the number of items per row
                                  crossAxisSpacing: 10, // Spacing between items
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 93,
                                ),
                                children: [
                                  BloodTypeButton(
                                    image: "assets/images/nav_bar/drop-1.png",
                                    text: "A Positive",
                                    onTap: () {
                                      setState(() {
                                        currentIndex = 0;
                                      });
                                    },
                                    tapped: currentIndex == 0,
                                  ),
                                  BloodTypeButton(
                                    image: "assets/images/nav_bar/drop-1.png",
                                    text: "A Negative",
                                    onTap: () {
                                      setState(() {
                                        currentIndex = 1;
                                      });
                                    },
                                    tapped: currentIndex == 1,
                                  ),
                                  BloodTypeButton(
                                    image: "assets/images/nav_bar/drop-1.png",
                                    text: "B Positive",
                                    onTap: () {
                                      setState(() {
                                        currentIndex = 2;
                                      });
                                    },
                                    tapped: currentIndex == 2,
                                  ),
                                  BloodTypeButton(
                                    image: "assets/images/nav_bar/drop-1.png",
                                    text: "B Negative",
                                    onTap: () {
                                      setState(() {
                                        currentIndex = 3;
                                      });
                                    },
                                    tapped: currentIndex == 3,
                                  ),
                                  BloodTypeButton(
                                    image: "assets/images/nav_bar/drop-1.png",
                                    text: "AB Positive",
                                    onTap: () {
                                      setState(() {
                                        currentIndex = 4;
                                      });
                                    },
                                    tapped: currentIndex == 4,
                                  ),
                                  BloodTypeButton(
                                    image: "assets/images/nav_bar/drop-1.png",
                                    text: "ABNegative",
                                    onTap: () {
                                      setState(() {
                                        currentIndex = 5;
                                      });
                                    },
                                    tapped: currentIndex == 5,
                                  ),
                                  BloodTypeButton(
                                    image: "assets/images/nav_bar/drop-1.png",
                                    text: "O Positive",
                                    onTap: () {
                                      setState(() {
                                        currentIndex = 6;
                                      });
                                    },
                                    tapped: currentIndex == 6,
                                  ),
                                  BloodTypeButton(
                                    image: "assets/images/nav_bar/drop-1.png",
                                    text: "O Negative",
                                    onTap: () {
                                      setState(() {
                                        currentIndex = 7;
                                      });
                                    },
                                    tapped: currentIndex == 7,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Number of pints",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 150,
                      child: CustomTextField(
                        controller: _qController,
                        keyboardType: TextInputType.number,
                        hintText: "20",
                        onChange: () {
                          setState(() {});
                        },
                        prefix: IconButton(
                          onPressed: () {
                            try {
                              int pints = int.parse(_qController.text);
                              if (pints != 1) pints = --pints;
                              _qController.text = pints.toString();
                              setState(() {});
                            } catch (e) {}
                          },
                          icon: Icon(Icons.remove),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            int pints = int.parse(_qController.text);
                            pints = ++pints;
                            _qController.text = pints.toString();
                            setState(() {});
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Constants.gap(height: 50),
              Container(
                // width: 100,
                child: Center(
                  child: CustomButton(
                    // width: MediaQuery.sizeOf(context).width * .8,
                    enable: currentIndex != -1 &&
                        int.parse(_qController.text.isEmpty
                                ? "0"
                                : _qController.text) >=
                            1,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AvailableNearbyBanksScreen(
                            latitude: double.parse(widget.lat),
                            longitude: double.parse(widget.long),
                            address: widget.address,
                            bloodType: bloodTypes[currentIndex],
                            pints: int.parse(_qController.text),
                          ),
                        ),
                      );
                    },
                    title: "Next",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // body:,
    );
  }
}

class BloodTypeButton extends StatelessWidget {
  const BloodTypeButton(
      {super.key,
      required this.image,
      required this.text,
      required this.onTap,
      required this.tapped});
  final String image;
  final String text;
  final Function() onTap;
  final bool tapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 93,
        width: 60,
        decoration: BoxDecoration(
            border:
                Border.all(color: tapped ? Constants.darkPink : Constants.grey),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(
              image,
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
            Constants.gap(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}

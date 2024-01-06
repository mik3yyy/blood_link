import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/main_screens/donor_main_screens/donate_screen/find_banks.dart';
import 'package:blood_link/main_screens/donor_main_screens/request_screen/getBloodType.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/google.dart';
import 'package:blood_link/settings/print.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  TextEditingController controller = TextEditingController();
  String lat = '';
  String long = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * .5,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * .4,
                    color: Constants.darkPink,
                    child: Column(
                      children: [
                        Constants.gap(
                            height: MediaQuery.of(context).size.height * .13),
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
                    height: 200,
                    decoration: BoxDecoration(
                      color: Constants.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Find Blood bank",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                        Constants.gap(height: 20),
                        GooglePlaceAutoCompleteTextField(
                          textEditingController: controller,
                          googleAPIKey: Google.apikey,

                          inputDecoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your Location",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Constants.grey,
                            ),
                            focusedBorder: InputBorder.none,
                          ),

                          debounceTime: 800, // default 600 ms,
                          countries: const [
                            "ng",
                          ], // optional by default null is set
                          isLatLngRequired:
                              true, // if you required coordinates from place detail
                          getPlaceDetailWithLatLng: (Prediction prediction) {
                            // this method will return latlng with place detail
                            // print("lng " + prediction.lng.toString());
                            // print("lat " + prediction.lat.toString());
                            setState(() {
                              lat = prediction.lat!;
                              long = prediction.lng!;
                            });
                          }, // this callback is called when isLatLngRequired is true
                          itemClick: (Prediction prediction) {
                            controller.text = prediction.description!;

                            controller.selection = TextSelection.fromPosition(
                                TextPosition(
                                    offset: prediction.description!.length));
                          },
                          // if we want to make custom list item builder
                          itemBuilder: (context, index, Prediction prediction) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Text(
                                          "${prediction.description ?? ""}"))
                                ],
                              ),
                            );
                          },
                          // if you want to add seperator between list items
                          seperatedBuilder: Divider(),
                          // want to show close icon
                          isCrossBtnShown: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // width: 100,
            child: Center(
              child: CustomButton(
                enable: lat.isNotEmpty && long.isNotEmpty,
                // width: MediaQuery.sizeOf(context).width * .8,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GetBloddType(
                                lat: lat,
                                long: long,
                                address: controller.text,
                              )));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => NearbyBanksScreen(
                  //       latitude: double.parse(lat),
                  //       longitude: double.parse(long),
                  //       address: controller.text,
                  //     ),
                  //   ),
                  // );
                },
                title: "Next",
              ),
            ),
          )
        ],
      ),
      // body:,
    );
  }
}

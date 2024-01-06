import 'dart:convert';

import 'package:blood_link/authentication/complete_donor_profile/basic_info_function.dart';
import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_text_button.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:blood_link/main_screens/donor_main_screens/donor_main_screen.dart';
import 'package:blood_link/main_screens/donor_main_screens/profile_screen/edit_profile/edit_profile_function.dart';
import 'package:blood_link/models/donor.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/Blood.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/print.dart';
import 'package:blood_link/settings/time.dart';
import 'package:crypto/crypto.dart';
import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  static String id = "/edit_profile";
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _fController = TextEditingController();
  final TextEditingController _lController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  bool obscuretext = true;
  bool loading = false;
  bool _isRememberMeChecked = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
//GENDER
  List<String> genders = Constants.genders;
  String gender = '';

  String bloodType = '';

  List<String> Year = Time.years;
  String year = '';

  List<String> Month = Time.months;
  String month = '';

  late PhoneNumberInputController phoneController;
  String phoneNumber = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController = PhoneNumberInputController(context);
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    Donor donor = authProvider.donor!;
    _fController.text = donor.firstName;
    _lController.text = donor.lastName;
    bloodType = donor.bloodType;
    gender = donor.gender;
    year = donor.dateOfBirth.year.toString();
    month = Time.months[donor.dateOfBirth.month];
    _dayController.text = Time.daysInMonth[donor.dateOfBirth.day];
  }

  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);

    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Account Settings"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 15.0),
                  const Text(
                    "First Name",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: _fController,
                    hintText: "First Name",
                    onChange: () {
                      setState(() {});
                    },
                    prefix: Icon(Icons.person_outline),
                  ),
                  SizedBox(height: 15.0),
                  const Text(
                    "Last Name",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: _lController,
                    hintText: "Last Name",
                    onChange: () {
                      setState(() {});
                    },
                    prefix: Icon(Icons.person_2_outlined),
                  ),
                  SizedBox(height: 15.0),
                  const Text(
                    "Blood Type",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Constants.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Constants.grey),
                    ),
                    child: DropDown(
                      initialValue: bloodType,
                      isExpanded: true,
                      items: Blood.validBloodTypes,
                      showUnderline: false,
                      hint: Text("BloodType"),
                      icon: Icon(
                        Icons.expand_more,
                        color: Constants.black,
                      ),
                      onChanged: (value) {
                        setState(() {
                          bloodType = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15.0),
                  const Text(
                    "Date of birth",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Constants.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Constants.grey),
                          ),
                          child: DropDown(
                            isExpanded: true,
                            items: Month,
                            initialValue: month,
                            showUnderline: false,
                            hint: Text("Month"),
                            icon: Icon(
                              Icons.expand_more,
                              color: Constants.black,
                            ),
                            onChanged: (value) {
                              setState(() {
                                month = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Constants.gap(width: 10),
                      // Expanded(
                      //   child: CustomTextField(
                      //     controller: _dayController,
                      //     hintText: "Day",
                      //     keyboardType: TextInputType.number,
                      //     onChange: () {},
                      //   ),
                      // ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Constants.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Constants.grey),
                          ),
                          child: DropDown(
                            isExpanded: true,
                            initialValue: _dayController.text,
                            items: Time.daysInMonth,
                            showUnderline: false,
                            hint: Text("Day"),
                            icon: Icon(
                              Icons.expand_more,
                              color: Constants.black,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _dayController.text = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Constants.gap(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Constants.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Constants.grey),
                          ),
                          child: DropDown(
                            isExpanded: true,
                            items: Year,
                            initialValue: year,
                            showUnderline: false,
                            hint: Text("Year"),
                            icon: Icon(
                              Icons.expand_more,
                              color: Constants.black,
                            ),
                            onChanged: (value) {
                              setState(() {
                                year = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  const Text(
                    "Phone number",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  PhoneNumberInput(
                    initialValue: authProvider.donor!.phoneNumber,
                    initialCountry: 'NG',
                    allowPickFromContacts: false,
                    controller: phoneController,
                    // includedCountries: const ["Nigeria", "Ghana"],
                    countryListMode: CountryListMode.dialog,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    onChanged: (String value) {
                      // print(value.length == 14);
                      // print(value);
                      if (value.length == 14) {
                        setState(() {
                          phoneNumber = value;
                        });
                      } else {
                        setState(() {
                          phoneNumber = "";
                        });
                      }
                    },
                    errorText: "Invaild Nigerian number",
                  ),
                  SizedBox(height: 15.0),
                  const Text(
                    "Gender",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Constants.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Constants.grey),
                    ),
                    child: DropDown(
                      initialValue: gender,
                      isExpanded: true,
                      items: genders,
                      showUnderline: false,
                      hint: Text("Gender"),
                      icon: Icon(
                        Icons.expand_more,
                        color: Constants.black,
                      ),
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                  ),
                  Constants.gap(height: 30),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: CustomButton(
            title: 'Save Changes',
            loading: loading,
            enable: _fController.text.isNotEmpty &&
                _lController.text.isNotEmpty &&
                bloodType.isNotEmpty &&
                month.isNotEmpty &&
                _dayController.text.isNotEmpty &&
                year.isNotEmpty &&
                phoneNumber.isNotEmpty &&
                gender.isNotEmpty,
            onTap: () async {
              setState(() {
                loading = true;
              });

              Donor donor = Donor(
                firstName: _fController.text,
                lastName: _lController.text,
                bloodType: bloodType,
                dateOfBirth: DateTime(
                  int.parse(year),
                  Time.getMonthIndex(month),
                  int.parse(_dayController.text),
                ),
                phoneNumber: phoneNumber,
                gender: gender,
                email: authProvider.donor!.email,
                password: authProvider.donor!.password,
              );
              await EditProfileFunction.updateDonorByEmail(
                  donor: donor, context: context, scaffoldKey: scaffoldKey);
              // await BasicInfoFunction.completeProfile(
              //     donor: donor, scaffoldKey: scaffoldKey, context: context);
              setState(() {
                loading = false;
              });
              // Implement sign-in logic
            },
          ),
        ),
      ),
    );
  }
}

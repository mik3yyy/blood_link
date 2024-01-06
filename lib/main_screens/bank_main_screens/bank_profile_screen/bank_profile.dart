import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/global_comonents/custom_text_button.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_drawer.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_profile_screen/bank_profile_function.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/Blood.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/google.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';

class BankProfileScreen extends StatefulWidget {
  const BankProfileScreen({super.key});
  static String id = '/bank_profile';
  @override
  State<BankProfileScreen> createState() => _BankProfileScreenState();
}

class _BankProfileScreenState extends State<BankProfileScreen> {
  bool obscuretext = true;
  bool _isRememberMeChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  TextEditingController controller = TextEditingController();

  bool loading = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final TextEditingController _passwordController = TextEditingController();
  String lat = '';
  String long = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    BloodBank bank = authProvider.bank!;
    _emailController.text = bank.email;
    _nameController.text = bank.bankName;
    controller.text = bank.address;
    lat = bank.latitude;
    long = bank.longitude;
  }

  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        key: _key, // Assign the key to Scaffold.

        drawer: BankDrawer(),
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Profile",
            style: TextStyle(
              color: Constants.white,
            ),
          ),
          backgroundColor: Constants.darkPink,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Constants.white,
            ),
            onPressed: () {
              // Scaffold.of(context).openDrawer();
              _key.currentState!.openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(
                'Profile settings',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email Address",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: _emailController,
                    hintText: "example@gmail.com",
                    onChange: () {
                      setState(() {});
                    },
                    prefix: Icon(Icons.email_outlined),
                  ),
                  Constants.gap(height: 20),
                  const Text(
                    "Blood Bank Name",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: _nameController,
                    hintText: "dPrecise",
                    onChange: () {
                      setState(() {});
                    },
                    prefix: Icon(Icons.person_2_outlined),
                  ),
                  Constants.gap(height: 20),
                  const Text(
                    "Address",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GooglePlaceAutoCompleteTextField(
                    textEditingController: controller,
                    googleAPIKey: Google.apikey,

                    inputDecoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),

                    debounceTime: 800, // default 600 ms,
                    // countries: ["in", "fr"], // optional by default null is set
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
                          TextPosition(offset: prediction.description!.length));
                    },
                    // if we want to make custom list item builder
                    itemBuilder: (context, index, Prediction prediction) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                                child: Text("${prediction.description ?? ""}"))
                          ],
                        ),
                      );
                    },
                    // if you want to add seperator between list items
                    seperatedBuilder: Divider(),
                    // want to show close icon
                    isCrossBtnShown: true,
                  ),
                  SizedBox(height: 20.0),
                  const Text(
                    "Password",
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    obscureText: obscuretext,
                    hintText: "Chinedum12#",
                    onChange: () {
                      setState(() {});
                    },
                    prefix: Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscuretext = !obscuretext;
                        });
                      },
                      icon: obscuretext
                          ? Icon(Icons.visibility_outlined)
                          : Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                ],
              ),
              Constants.gap(height: 20),
              CustomButton(
                loading: loading,
                enable: _emailController.text.isNotEmpty &&
                    controller.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty,
                onTap: () async {
                  if (authProvider.bank!.password ==
                      Constants.hashPassword(_passwordController.text)) {
                    setState(() {
                      loading = true;
                    });
                    BloodBank bloodBank = authProvider.bank!;

                    BloodBank newbloodBank = BloodBank(
                      bankName: _nameController.text,
                      bankId: bloodBank.bankId,
                      latitude: lat,
                      longitude: long,
                      address: controller.text,
                      email: _emailController.text,
                      password: bloodBank.password,
                    );
                    await BankProfileFunction.editProfile(
                      bloodBank: newbloodBank,
                      scaffoldKey: scaffoldKey,
                      context: context,
                    );

                    setState(() {
                      loading = false;
                    });
                  } else {
                    MyMessageHandler.showSnackBar(
                        scaffoldKey, "Incorrect Password");
                  }
                },
                title: "Save Changes",
              )
            ],
          ),
        ),
      ),
    );
  }
}

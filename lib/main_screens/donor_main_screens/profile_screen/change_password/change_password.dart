import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:blood_link/main_screens/donor_main_screens/profile_screen/edit_profile/edit_profile_function.dart';
import 'package:blood_link/main_screens/donor_main_screens/profile_screen/edit_profile/edit_profile_screen.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key, required this.donor});
  final Donor donor;
  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _npasswordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  bool obscuretext = true;
  bool obscuretext2 = true;
  bool obscuretext3 = true;
  bool loading = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Change Password"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Current Password",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _passwordController,
                obscureText: obscuretext,
                hintText: "Chinedum12#",
                onChange: () {},
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
              SizedBox(height: 10.0),
              const Text(
                "New Password",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _npasswordController,
                obscureText: obscuretext2,
                hintText: "Chinedum12#",
                onChange: () {},
                prefix: Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscuretext2 = !obscuretext2;
                    });
                  },
                  icon: obscuretext2
                      ? Icon(Icons.visibility_outlined)
                      : Icon(Icons.visibility_off_outlined),
                ),
              ),
              SizedBox(height: 10.0),
              const Text(
                "Confirm Password",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: _cpasswordController,
                obscureText: obscuretext3,
                hintText: "Chinedum12#",
                onChange: () {},
                prefix: Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscuretext3 = !obscuretext3;
                    });
                  },
                  icon: obscuretext3
                      ? Icon(Icons.visibility_outlined)
                      : Icon(Icons.visibility_off_outlined),
                ),
              ),
              SizedBox(height: 30.0),
              CustomButton(
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  if (Constants.hashPassword(_passwordController.text) ==
                      widget.donor.password) {
                    if (_cpasswordController.text ==
                        _npasswordController.text) {
                      Donor donor = widget.donor;
                      Donor newDonor = Donor(
                        firstName: donor.firstName,
                        lastName: donor.lastName,
                        bloodType: donor.bloodType,
                        dateOfBirth: donor.dateOfBirth,
                        phoneNumber: donor.phoneNumber,
                        gender: donor.gender,
                        email: donor.email,
                        password:
                            Constants.hashPassword(_cpasswordController.text),
                      );
                      await EditProfileFunction.updateDonorByEmail(
                        donor: donor,
                        context: context,
                        scaffoldKey: scaffoldKey,
                      );
                    } else {
                      MyMessageHandler.showSnackBar(
                          scaffoldKey, "Confirm Password Failed");
                    }
                  } else {
                    MyMessageHandler.showSnackBar(
                        scaffoldKey, "Password incorrect");
                  }
                  setState(() {
                    loading = false;
                  });
                },
                enable: _passwordController.text.isNotEmpty &&
                    _npasswordController.text.isNotEmpty &&
                    _cpasswordController.text.isNotEmpty,
                title: "Save Changes",
              )
            ],
          ),
        ),
      ),
    );
  }
}

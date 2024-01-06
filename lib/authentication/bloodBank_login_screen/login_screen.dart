import 'package:blood_link/authentication/bloodBank_login_screen/login_function.dart';
import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_text_button.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';

class BloodBankLoginScreen extends StatefulWidget {
  static String id = "/blood_login_screen";
  @override
  State<BloodBankLoginScreen> createState() => _BloodBankLoginScreenState();
}

class _BloodBankLoginScreenState extends State<BloodBankLoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool obscuretext = true;
  bool _isRememberMeChecked = false;
  bool loading = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              color: Constants.black,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Sign in to your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Welcome back! You have been missed.",
                  textAlign: TextAlign.center,
                  style: Constants.Montserrat.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 48.0),
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
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(

                        // minWidth: ,
                        text: 'Forgot Password?',
                        onPressed: () {
                          // Implement forgot password logic
                        },
                        color: Constants.darkPink
                        // Assuming red is the color for your 'Forgot Password?' button
                        ),
                  ],
                ),
                SizedBox(height: 10.0),
                CustomButton(
                  title: 'Sign In',
                  loading: loading,
                  enable: _emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty,
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    await BloodLoginFunction.bloodLogin(
                        email: _emailController.text,
                        password: _passwordController.text,
                        scaffoldKey: scaffoldKey,
                        context: context);
                    setState(() {
                      loading = false;
                    });
                    // Implement sign-in logic
                  },
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: Container(
        //   height: 100,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'Don\'t have an account? ',
        //       ),
        //       CustomTextButton(
        //         text: "Sign up",
        //         color: Constants.darkPink,
        //         onPressed: () {
        //           Navigator.pushNamed(context, SignupScreen.id);
        //         },
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

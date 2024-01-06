import 'package:blood_link/authentication/login_screen/login_function.dart';
import 'package:blood_link/authentication/sign_up/sign_up.dart';
import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_text_button.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/main_screens/donor_main_screens/donor_main_screen.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = "/login_screen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool obscuretext = true;
  bool _isRememberMeChecked = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool loading = false;
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
        body: Padding(
          padding: EdgeInsets.all(16.0),
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
                onChange: () {},
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
                onTap: () async {
                  setState(() {
                    loading = true;
                  });

                  await LoginFunction.donorLogin(
                    email: _emailController.text,
                    password: _passwordController.text,
                    scaffoldKey: scaffoldKey,
                    context: context,
                  );
                  setState(() {
                    loading = false;
                  });
                  // Navigator.pushNamed(context, DonorMainScreen.id);

                  // Implement sign-in logic
                },
              ),
              // SizedBox(height: 20.0),
              // Row(
              //   children: [
              //     Expanded(
              //         child: Container(
              //       color: Constants.grey,
              //       height: 1,
              //     )),
              //     Container(
              //         width: 130,
              //         child: Center(child: Text("or Sign in with?"))),
              //     Expanded(
              //         child: Container(
              //       color: Constants.grey,
              //       height: 1,
              //     )),
              //   ],
              // ),
              // SizedBox(height: 20.0),
              // CustomButtonSecondary(
              //   title: 'Sign in with Google',
              //   onTap: () {
              //     // Implement Google sign-in logic
              //   },
              // ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account? ',
              ),
              CustomTextButton(
                text: "Sign up",
                color: Constants.darkPink,
                onPressed: () {
                  Navigator.pushNamed(context, SignupScreen.id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

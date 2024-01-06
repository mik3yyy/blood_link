import 'package:blood_link/authentication/complete_donor_profile/basic_info.dart';
import 'package:blood_link/authentication/login_screen/login_screen.dart';
import 'package:blood_link/authentication/sign_up/sign_up_function.dart';
import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_text_button.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static String id = '/sign_up';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  late TapGestureRecognizer _tapGestureRecognizer;
  late TapGestureRecognizer _tapGestureRecognizerTerms;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final TextEditingController _passwordController = TextEditingController();
  bool obscuretext = true;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = () {};
    _tapGestureRecognizerTerms = TapGestureRecognizer()..onTap = () {};
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Create an account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Let’s get you started. Please enter your details",
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
              SizedBox(height: 40.0),
              CustomButton(
                title: 'Continue',
                loading: loading,
                enable: _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  await SignUpFunction.checkUser(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context,
                      scaffoldKey: scaffoldKey);

                  // Implement sign-in logic
                  setState(() {
                    loading = false;
                  });
                },
              ),
              SizedBox(height: 30.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Constants.Montserrat.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: 'By clicking “Continue”, you agree to accept our ',
                      style: Constants.Montserrat.copyWith(
                        color: Constants.black,
                      ),
                    ),
                    TextSpan(
                      text: "Privacy Policy",
                      recognizer: _tapGestureRecognizer,
                      style: Constants.Montserrat.copyWith(
                        color: Constants.darkPink,
                      ),
                    ),
                    TextSpan(
                      text: " and our ",
                      style: Constants.Montserrat.copyWith(
                        color: Constants.black,
                      ),
                    ),
                    TextSpan(
                      text: "Terms and condition",
                      recognizer: _tapGestureRecognizerTerms,
                      style: Constants.Montserrat.copyWith(
                        color: Constants.darkPink,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
              ),
              CustomTextButton(
                text: "Sign in",
                color: Constants.darkPink,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

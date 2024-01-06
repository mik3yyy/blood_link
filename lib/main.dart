import 'package:blood_link/authentication/bloodBank_login_screen/login_screen.dart';
import 'package:blood_link/authentication/complete_donor_profile/basic_info.dart';
import 'package:blood_link/authentication/login_screen/login_screen.dart';
import 'package:blood_link/authentication/sign_up/sign_up.dart';
import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_campaign_screen/bank_campaign_screen.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_donor_manager_screen/bank_donor_manager_screen.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_home_screen/bank_main_screen.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_order_screen/bank_order_screen.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_profile_screen/bank_profile.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_request_manager/bank_request_screen.dart';
import 'package:blood_link/main_screens/donor_main_screens/donor_main_screen.dart';
import 'package:blood_link/main_screens/donor_main_screens/home_screen/view_campaign.dart';
import 'package:blood_link/onboarding/onboarding-option.dart';
import 'package:blood_link/onboarding/onboarding.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/providers/main_provider.dart';
import 'package:blood_link/settings/print.dart';
import 'package:blood_link/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Print("initialized"));
  await Hive.initFlutter();
  Hive.registerAdapter(DonorAdapter());
  Hive.registerAdapter(BloodBankAdapter());
  await Hive.openBox('donorBox');
  await Hive.openBox('bankBox');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      // home: OnboardingScreen(),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        OnboardingOption.id: (context) => OnboardingOption(),
        OnboardingScreen.id: (context) => OnboardingScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        BloodBankLoginScreen.id: (context) => BloodBankLoginScreen(),
        DonorMainScreen.id: (context) => DonorMainScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        BasicInfoScreen.id: (context) => BasicInfoScreen(),
        BankMainScreen.id: (context) => BankMainScreen(),
        BankProfileScreen.id: (context) => BankProfileScreen(),
        BankCampaign.id: (context) => BankCampaign(),
        BankDonorManagerScreen.id: (context) => BankDonorManagerScreen(),
        BankRequestManager.id: (context) => BankRequestManager(),
        BankOrderScreen.id: (context) => BankOrderScreen(),
      },
    );
  }
}

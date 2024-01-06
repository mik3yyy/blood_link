import 'package:blood_link/authentication/login_screen/login_function.dart';
import 'package:blood_link/main_screens/donor_main_screens/appointment_screen/appoint_screen.dart';
import 'package:blood_link/main_screens/donor_main_screens/donate_screen/donate_screen.dart';
import 'package:blood_link/main_screens/donor_main_screens/donor_main_function.dart';
import 'package:blood_link/main_screens/donor_main_screens/home_screen/home_screen.dart';
import 'package:blood_link/main_screens/donor_main_screens/profile_screen/profile_screen.dart';
import 'package:blood_link/main_screens/donor_main_screens/request_screen/request_screen.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DonorMainScreen extends StatefulWidget {
  const DonorMainScreen({super.key});
  static String id = "/donor_main";
  @override
  State<DonorMainScreen> createState() => _DonorMainScreenState();
}

class _DonorMainScreenState extends State<DonorMainScreen> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    var bank = authProvider.donor!;
    DonormainFunction.donorReload(
      email: bank.email,
      password: bank.password,
      scaffoldKey: scaffoldKey,
      context: context,
    );
    // LoginFunction.donorLogin(
    //     email: authProvider.donor!.email,
    //     password: Constants.hashPassword(authProvider.donor!.password),
    //     scaffoldKey: scaffoldKey,
    //     context: context);
  }

  @override
  Widget build(BuildContext context) {
    final _sceens = <Widget>[
      HomeScreen(),
      DonateScreen(),
      AppointmentScreen(),
      RequestScreen(),
      ProfileScreen()
    ];
    return Scaffold(
      body: _sceens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: currentIndex,
        selectedItemColor: Constants.darkPink,
        unselectedItemColor: Constants.black,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        // selectedLabelStyle:
        //     currentIndex == 2 ? TextStyle(fontSize: 10) : null,
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 30,
              height: 30,
              child: currentIndex == 0
                  ? Image.asset("assets/images/nav_bar/home-1.png")
                  : Image.asset("assets/images/nav_bar/home-2.png"),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 30,
              height: 30,
              child: currentIndex == 1
                  ? Image.asset("assets/images/nav_bar/drop-1.png")
                  : Image.asset("assets/images/nav_bar/drop-2.png"),
            ),
            label: "Donate",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 30,
              height: 30,
              child: currentIndex == 2
                  ? Image.asset("assets/images/nav_bar/appointment-1.png")
                  : Image.asset("assets/images/nav_bar/appointment-2.png"),
            ),
            label: "Invites",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 30,
              height: 30,
              child: currentIndex == 3
                  ? Image.asset("assets/images/nav_bar/search-1.png")
                  : Image.asset("assets/images/nav_bar/search-2.png"),
            ),
            label: "Requests",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 30,
              height: 30,
              child: currentIndex == 4
                  ? Image.asset("assets/images/nav_bar/profile-1.png")
                  : Image.asset("assets/images/nav_bar/profile-2.png"),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class DonorButton extends StatefulWidget {
  DonorButton(
      {super.key,
      required this.onTap,
      required this.subtitle,
      required this.title,
      required this.iconBackgroundColor,
      required this.iconColor,
      required this.subTextBackgroundColor,
      required this.icon});
  final Function onTap;
  final String title;
  final String subtitle;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color subTextBackgroundColor;
  final IconData icon;

  @override
  State<DonorButton> createState() => _DonorButtonState();
}

class _DonorButtonState extends State<DonorButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap(),
      child: Container(
        height: 200,
        width: 136,
        decoration: BoxDecoration(
          color: Constants.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: widget.iconBackgroundColor,
              radius: 24,
              child: Icon(
                widget.icon,
                size: 20,
                color: widget.iconColor,
              ),
            ),
            Text(
              widget.title,
              style: Constants.Montserrat.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.subTextBackgroundColor,
              ),
              child: Center(
                  child: Text(
                widget.subtitle,
                style: TextStyle(
                  color: Constants.white,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}


    //  Expanded(
    //             child: Container(
    //               child: Stack(
    //                 children: [
    //                   Positioned(
    //                     top: 0,
    //                     left: 00,
    //                     right: 0,
    //                     child: Image.asset(
    //                       "assets/images/donor_main_screen/graph.png",
    //                       // height: 3409,
    //                     ),
    //                   ),
    //                   Positioned(
    //                     top: 140,
    //                     child: Container(
    //                       width: MediaQuery.sizeOf(context).width,
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           Container(
    //                             height: 400,
    //                             width: MediaQuery.sizeOf(context).width * 0.7,
    //                             decoration: BoxDecoration(
    //                               color: Constants.transperent,
    //                             ),
    //                             child: GridView(
    //                               gridDelegate:
    //                                   const SliverGridDelegateWithFixedCrossAxisCount(
    //                                 crossAxisCount: 2,
    //                                 mainAxisSpacing: 10,
    //                                 crossAxisSpacing: 10,
    //                               ),
    //                               children: [
    //                                 DonorButton(
    //                                   onTap: () {},
    //                                   title: "Find A Donor",
    //                                   subtitle: "235k",
    //                                   icon: FontAwesomeIcons.magnifyingGlass,
    //                                   iconBackgroundColor: Constants
    //                                       .DonorMainColor["find"]["bg"],
    //                                   iconColor: Constants
    //                                       .DonorMainColor["find"]["icon"],
    //                                   subTextBackgroundColor:
    //                                       Constants.DonorMainColor["subTitle"],
    //                                 ),
    //                                 DonorButton(
    //                                   icon: FontAwesomeIcons.bell,
    //                                   onTap: () {},
    //                                   title: "Blood Request",
    //                                   subtitle: "500k",
    //                                   iconBackgroundColor: Constants
    //                                       .DonorMainColor["request"]["bg"],
    //                                   iconColor: Constants
    //                                       .DonorMainColor["request"]["icon"],
    //                                   subTextBackgroundColor:
    //                                       Constants.DonorMainColor["subTitle"],
    //                                 ),
    //                                 DonorButton(
    //                                   icon: FontAwesomeIcons.droplet,
    //                                   onTap: () {},
    //                                   title: "Blood Bank",
    //                                   subtitle: "Map",
    //                                   iconBackgroundColor: Constants
    //                                       .DonorMainColor["bank"]["bg"],
    //                                   iconColor: Constants
    //                                       .DonorMainColor["bank"]["icon"],
    //                                   subTextBackgroundColor:
    //                                       Constants.DonorMainColor["subTitle"],
    //                                 ),
    //                                 DonorButton(
    //                                   icon: Icons.settings,
    //                                   onTap: () {},
    //                                   title: "Other",
    //                                   subtitle: "More",
    //                                   iconBackgroundColor: Constants
    //                                       .DonorMainColor["other"]["bg"],
    //                                   iconColor: Constants
    //                                       .DonorMainColor["other"]["icon"],
    //                                   subTextBackgroundColor:
    //                                       Constants.DonorMainColor["subTitle"],
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           )
           
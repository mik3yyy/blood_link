import 'dart:io';

import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_messageHandler.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_campaign_screen/bank_campaign_function.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_drawer.dart';
import 'package:blood_link/models/campaign.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:blood_link/settings/print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BankCampaign extends StatefulWidget {
  const BankCampaign({super.key});
  static String id = '/campaign_page';
  @override
  State<BankCampaign> createState() => _BankCampaignState();
}

class _BankCampaignState extends State<BankCampaign> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  PageController _pageController = PageController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  dynamic _pickedImageError;
  bool loading = false;
  final TextEditingController _emailController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      if (pickedImage!.path != null) {
        setState(() {
          _imageFile = pickedImage;
        });
      }
    } catch (e) {
      setState(() {
        _pickedImageError = e.toString();
      });
      MyMessageHandler.showSnackBar(scaffoldKey, _pickedImageError);
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        key: _key, // Assign the key to Scaffold.

        drawer: BankDrawer(),
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Campaign",
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
        body: Column(
          children: [
            Container(
              // height: 40,
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              color: Constants.darkPink,
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: Column(
                      children: [
                        Text(
                          'New Campaign',
                          style: TextStyle(
                            color: Constants.white,
                          ),
                        ),
                        // if (_pageController.page == 0)
                      ],
                    ),
                  )),
                  Constants.gap(width: 20),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: Column(
                      children: [
                        Text(
                          'My Campaigns',
                          style: TextStyle(
                            color: Constants.white,
                          ),
                        ),
                        // if (_pageController.page == 1)
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Container(
              height: 10,
              // padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              color: Constants.darkPink,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 2,
                effect: WormEffect(
                  activeDotColor: Constants.white,
                  dotColor: Constants.darkPink,
                  dotHeight: 10,
                  dotWidth: MediaQuery.sizeOf(context).width * 0.5,
                ),
              ),
            ),
            Expanded(
                child: PageView(
              controller: _pageController,
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onLongPress: () {
                            setState(() {
                              _imageFile = null;
                            });
                          },
                          onTap: _imageFile != null
                              ? () {}
                              : () {
                                  _pickImageFromGallery();
                                },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(12),
                            color: Constants.grey,
                            // strokeWidth: 4,
                            // stackFit: StackFit.expand,
                            padding: EdgeInsets.all(6),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Stack(
                                  children: [
                                    Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: _imageFile != null
                                            ? Image.file(
                                                File(_imageFile!.path),
                                                fit: BoxFit.fill,
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.image,
                                                      size: 80,
                                                      color: Colors.grey
                                                          .withOpacity(0.7)),
                                                  Text("Add image"),
                                                  Text(
                                                    "You can remove an image by longing pressing it",
                                                    style: TextStyle(
                                                      color: Constants.grey,
                                                    ),
                                                  )
                                                ],
                                              )),
                                  ],
                                )),
                          ),
                        ),
                        Constants.gap(height: 25),
                        const Text(
                          "Campaign Title",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Campaign Title",
                          onChange: () {
                            setState(() {});
                          },
                        ),
                        Constants.gap(height: 25),
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Constants.gap(height: 5),
                        CustomTextField(
                          controller: descriptionController,
                          hintText: "Description",
                          onChange: () {
                            setState(() {});
                          },
                          maxLines: 10,
                        ),
                        Constants.gap(height: 15),
                        CustomButton(
                          enable: _imageFile != null &&
                              _emailController.text.isNotEmpty &&
                              descriptionController.text.isNotEmpty,
                          loading: loading,
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });

                            bool b = await BankCampaignFunction
                                .createAndUploadCampaign(
                                    bankId: authProvider.bank!.bankId,
                                    imageFile: File(_imageFile!.path),
                                    campaignTitle: _emailController.text,
                                    description: descriptionController.text,
                                    scaffoldKey: scaffoldKey,
                                    context: context);
                            if (b) {
                              setState(() {
                                _emailController.text = '';
                                descriptionController.text = '';
                                _imageFile = null;
                              });
                            } else {}
                            setState(() {
                              loading = false;
                            });
                          },
                          title: "Create Campaign",
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('campaigns')
                        .where('bankId', isEqualTo: authProvider.bank!.bankId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (!snapshot.hasData) {
                        return Text('No Campaigns Found');
                      }

                      // Extracting data into a list of campaigns
                      List<Campaign> campaigns =
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Campaign(
                          bankId: data['bankId'],
                          image: data['image'],
                          campaignTitle: data['campaignTitle'],
                          timestap: data['timestap'],
                          description: data['description'],
                        );
                      }).toList();

                      // Building a list view of campaign items
                      return ListView.builder(
                        itemCount: campaigns.length,
                        itemBuilder: (context, index) {
                          DateTime date =
                              DateTime.parse(campaigns[index].timestap);

                          return Slidable(
                            // Specify a key if the Slidable is dismissible.
                            key: const ValueKey(0),

                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible: DismissiblePane(onDismissed: () {}),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {});
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),

                            // The end action pane is the one at the right or the bottom side.
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {});
                                    BankCampaignFunction.deleteDocument(
                                        documentId:
                                            snapshot.data!.docs[index].id,
                                        context: context,
                                        scaffoldKey: scaffoldKey);
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),

                            // The child of the Slidable is what the user sees when the
                            // component is not dragged.
                            child: ListTile(
                              leading: Image.network(
                                campaigns[index].image,
                                fit: BoxFit.fitHeight,
                                height: 50,
                                width: 50,
                              ),
                              title: Text(
                                campaigns[index].campaignTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                " ${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Constants.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}

import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/main_screens/donor_main_screens/home_screen/view_campaign_function.dart';
import 'package:blood_link/models/campaign.dart';
import 'package:flutter/material.dart';

class ViewCampaign extends StatefulWidget {
  const ViewCampaign({super.key, required this.campaign});
  final Campaign campaign;
  static String id = "/view-campaign";
  @override
  State<ViewCampaign> createState() => _ViewCampaignState();
}

class _ViewCampaignState extends State<ViewCampaign> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Campaign"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.campaign.image,
                fit: BoxFit.cover,
                // Adjust the height as needed, or make it responsive
                height: 200,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.campaign.campaignTitle,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(widget.campaign.description),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: CustomButton(
            loading: loading,
            onTap: () async {
              setState(() {
                loading = true;
              });
              await ViewCampaignFunction.getBankDocumentById(
                  bankId: widget.campaign.bankId,
                  context: context,
                  scaffoldKey: scaffoldKey);
              setState(() {
                loading = false;
              });
            },
            title: "Donate Now",
          ),
        ),
      ),
    );
  }
}

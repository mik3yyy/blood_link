import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_order_screen/bank_order_function.dart';
import 'package:blood_link/models/request.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';

class ViewOrderDetails extends StatefulWidget {
  final Donor donor;
  final Request request;

  ViewOrderDetails({Key? key, required this.donor, required this.request})
      : super(key: key);

  @override
  _ViewOrderDetailsState createState() => _ViewOrderDetailsState();
}

class _ViewOrderDetailsState extends State<ViewOrderDetails> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: <Widget>[
                  _buildInfoRow('Name',
                      "${widget.donor.lastName} ${widget.donor.firstName}"),
                  _buildInfoRow('Gender', widget.donor.gender),
                  _buildInfoRow('Blood type', widget.request.bloodType),
                  _buildInfoRow('Quantity', widget.request.pints.toString()),
                  _buildInfoRow('Phone Number', widget.donor.phoneNumber),
                  _buildInfoRow('Email', widget.donor.email),
                  _buildInfoRow('Address', widget.request.address),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomButtonSecondary(
                          loading: loading,
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            await BankOrderFunction.updateRequestStatus(
                                docId: widget.request.requestId,
                                newStatus: Constants.validStatuses[2],
                                context: context,
                                scaffoldKey: scaffoldKey);
                            setState(() {
                              loading = false;
                            });
                          },
                          title: "Decline")),
                  Constants.gap(width: 10),
                  Expanded(
                      child: CustomButton(
                          loading: loading,
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            await BankOrderFunction.updateRequestStatus(
                                context: context,
                                docId: widget.request.requestId,
                                newStatus: Constants.validStatuses[1],
                                scaffoldKey: scaffoldKey);
                            setState(() {
                              loading = false;
                            });
                          },
                          title: "Accept")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

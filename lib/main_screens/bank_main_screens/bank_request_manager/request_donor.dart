import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_request_manager/bank_appointment_screen/bank_appointment_screen.dart';
import 'package:flutter/material.dart';

class RequestDonor extends StatefulWidget {
  final Donor donor;

  RequestDonor({Key? key, required this.donor}) : super(key: key);

  @override
  _RequestDonorState createState() => _RequestDonorState();
}

class _RequestDonorState extends State<RequestDonor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                _buildInfoRow('Name', widget.donor.lastName),
                _buildInfoRow('Gender', widget.donor.gender),
                _buildInfoRow('Blood type', widget.donor.bloodType),
                _buildInfoRow('Phone Number', widget.donor.phoneNumber),
                _buildInfoRow('Email', widget.donor.email),
                // _buildInfoRow('Reg date', widget.donor.registrationDate),
                // _buildInfoRow('Address', widget.donor.address),
              ],
            ),
            CustomButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BankBookAppointmentScreen(donor: widget.donor)));
              },
              title: "Request Now",
            ),
          ],
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

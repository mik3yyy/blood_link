import 'package:blood_link/global_comonents/custom_list_container.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:flutter/material.dart';

class DonorDetailsWidget extends StatefulWidget {
  final Donor donor;

  DonorDetailsWidget({Key? key, required this.donor}) : super(key: key);

  @override
  _DonorDetailsWidgetState createState() => _DonorDetailsWidgetState();
}

class _DonorDetailsWidgetState extends State<DonorDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Details'),
      ),
      body: Column(
        children: <Widget>[
          CustomListContainer(
            index: 0,
            child: _buildInfoRow('Name', widget.donor.lastName),
          ),
          CustomListContainer(
            index: 1,
            child: _buildInfoRow('Gender', widget.donor.gender),
          ),
          CustomListContainer(
            index: 2,
            child: _buildInfoRow('Blood type', widget.donor.bloodType),
          ),
          CustomListContainer(
            index: 3,
            child: _buildInfoRow('Phone Number', widget.donor.phoneNumber),
          ),
          CustomListContainer(
            index: 4,
            child: _buildInfoRow('Email', widget.donor.email),
          ),
          // _buildInfoRow('Reg date', widget.donor.registrationDate),
          // _buildInfoRow('Address', widget.donor.address),
        ],
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

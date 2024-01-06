import 'package:blood_link/settings/constants.dart';

class Request {
  final String requestId;
  String status;
  final String bankId;
  final String email;
  final String address;
  final int pints;
  final String bloodType;

  Request(
      {required this.requestId,
      required String status, // Keep it as String, but validate
      required this.bankId,
      required this.email,
      required this.address,
      required this.pints,
      required this.bloodType})
      : status = _validateStatus(status);

  static String _validateStatus(String status) {
    if (!Constants.validStatuses.contains(status)) {
      throw ArgumentError(
          'Invalid status: $status. Must be one of ${Constants.validStatuses.join(", ")}.');
    }
    return status;
  }

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'status': status,
      'bankId': bankId,
      'email': email,
      'address': address,
      'pints': pints,
      'bloodType': bloodType
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      requestId: map['requestId'],
      status: map['status'],
      bankId: map['bankId'],
      email: map['email'],
      address: map['address'],
      pints: map['pints'],
      bloodType: map['bloodType'],
    );
  }

  // ... other methods like fromMap ...
}

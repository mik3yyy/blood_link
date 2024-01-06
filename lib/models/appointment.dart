import 'package:blood_link/settings/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final Timestamp date;
  final String note;
  final String email;
  final String bankId;
  final String status; // "pending", "accepted", "declined"
  final Timestamp timestamp;

  Appointment({
    required this.date,
    required this.note,
    required this.email,
    required this.bankId,
    required String status,
    required this.timestamp,
  }) : status = _validateStatus(status);

  // Validation for status
  static String _validateStatus(String status) {
    var validStatuses = Constants.validStatuses;
    if (!validStatuses.contains(status)) {
      throw ArgumentError(
          'Invalid status: $status. Must be pending, accepted, or declined.');
    }
    return status;
  }

  // Convert a Appointment to a Map
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'note': note,
      'email': email,
      'bankId': bankId,
      'status': status,
      'timestamp': timestamp,
    };
  }

  // Create a Appointment from a Map
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      date: map['date'],
      note: map['note'],
      email: map['email'],
      bankId: map['bankId'],
      status: map['status'],
      timestamp: map['timestamp'],
    );
  }

  // Implement toString for debugging purposes
  @override
  String toString() {
    return 'Appointment(date: $date, note: $note, email: $email, bankId: $bankId, status: $status, timestamp: $timestamp)';
  }
}

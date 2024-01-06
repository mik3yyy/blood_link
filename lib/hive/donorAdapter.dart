import 'package:blood_link/settings/Blood.dart';
import 'package:blood_link/settings/validators.dart';
import 'package:hive/hive.dart';
part 'donorAdapter.g.dart';

@HiveType(typeId: 1)
class Donor extends HiveObject {
  @HiveField(0)
  final String firstName;

  @HiveField(1)
  final String lastName;

  @HiveField(2)
  final String bloodType; // Assuming BloodType is a Hive-compatible type

  @HiveField(3)
  final DateTime dateOfBirth;

  @HiveField(4)
  final String phoneNumber;

  @HiveField(5)
  final String gender;

  @HiveField(6)
  final String email;

  @HiveField(7)
  final String password;

  // Constructor
  Donor({
    required this.firstName,
    required this.lastName,
    required this.bloodType,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.gender,
    required this.email,
    required this.password,
  }) {
    // Validate blood type
    if (!Blood.validBloodTypes.contains(bloodType)) {
      throw ArgumentError('Invalid blood type: $bloodType');
    }
  }

  // Convert a Donor into a Map. The keys must correspond to the names of the JSON fields.
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'bloodType': bloodType,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'phoneNumber': phoneNumber,
      'gender': gender,
      'email': email,
      'password': password,
    };
  }

  // Implement toString to make it easier to see information about each donor when using the print statement.
  @override
  String toString() {
    return 'Donor(firstName: $firstName, lastName: $lastName, bloodType: $bloodType, dateOfBirth: ${dateOfBirth.toIso8601String()}, phoneNumber: $phoneNumber, gender: $gender, email: $email, password: $password)';
  }

  // A method to create a Donor from a map (extracting a Donor object from a map structure)
  factory Donor.fromMap(Map<String, dynamic> map) {
    return Donor(
      firstName: map['firstName'],
      lastName: map['lastName'],
      bloodType: map['bloodType'],
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      phoneNumber: map['phoneNumber'],
      gender: map['gender'],
      email: map['email'],
      password: map['password'],
    );
  }

  // Additional methods (toJson, fromJson, toString) can be added here
}

extension DonorValidation on Donor {
  String? isValidDonor() {
    if (this.phoneNumber.isValidPhoneNumber()) {
      return 'invalid phonenumber';
    }
    return null;
  }
}

import 'package:hive/hive.dart';

part 'bankAdapter.g.dart';

@HiveType(typeId: 2) // Ensure typeId is unique
class BloodBank extends HiveObject {
  @HiveField(0)
  final String bankName;

  @HiveField(1)
  final String bankId;

  @HiveField(2)
  final String latitude;

  @HiveField(3)
  final String longitude;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final String password;

  // Constructor
  BloodBank({
    required this.bankName,
    required this.bankId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.email,
    required this.password,
  });

  // Convert a BloodBank into a Map
  Map<String, dynamic> toMap() {
    return {
      'bankName': bankName,
      'bankId': bankId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'email': email,
      'password': password,
    };
  }

  // Create a BloodBank from a map
  factory BloodBank.fromMap(Map<String, dynamic> map) {
    return BloodBank(
      bankName: map['bankName'],
      bankId: map['bankId'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      email: map['email'],
      password: map['password'],
    );
  }

  // Implement toString for easier debugging
  @override
  String toString() {
    return 'BloodBank(bankName: $bankName, bankId: $bankId, latitude: $latitude, longitude: $longitude, address: $address, email: $email, password: $password)';
  }
}

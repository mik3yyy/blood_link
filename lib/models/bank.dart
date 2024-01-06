// class BloodBank {
//   final String bankName;
//   final String bankId;
//   final String latitude;
//   final String longitude;
//   final String address;
//   final String email;
//   final String password;

//   BloodBank({
//     required this.bankName,
//     required this.bankId,
//     required this.latitude,
//     required this.longitude,
//     required this.address,
//     required this.email,
//     required this.password,
//   });

//   // Convert a BloodBank into a Map. The keys must correspond to the names of the JSON fields.
//   Map<String, dynamic> toMap() {
//     return {
//       'bankName': bankName,
//       'bankId': bankId,
//       'latitude': latitude,
//       'longitude': longitude,
//       'address': address,
//       'email': email,
//       'password': password,
//     };
//   }

//   // Implement toString to make it easier to see information about the blood bank when using the print statement.
//   @override
//   String toString() {
//     return 'BloodBank(bankName: $bankName, bankId: $bankId, latitude: $latitude, longitude: $longitude, address: $address, email: $email, password: $password)';
//   }

//   // A method to create a BloodBank from a map (extracting a BloodBank object from a map structure)
//   factory BloodBank.fromMap(Map<String, dynamic> map) {
//     return BloodBank(
//       bankName: map['bankName'],
//       bankId: map['bankId'],
//       latitude: map['latitude'],
//       longitude: map['longitude'],
//       address: map['address'],
//       email: map['email'],
//       password: map['password'],
//     );
//   }
// }

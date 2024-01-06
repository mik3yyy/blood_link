import 'package:blood_link/models/bloodType.dart';

class Inventory {
  final String bankId;
  final BloodType aPositive;
  final BloodType aNegative;
  final BloodType bPositive;
  final BloodType bNegative;
  final BloodType abPositive;
  final BloodType abNegative;
  final BloodType oPositive;
  final BloodType oNegative;

  // Constructor
  Inventory({
    required this.bankId,
    required this.aPositive,
    required this.aNegative,
    required this.bPositive,
    required this.bNegative,
    required this.abPositive,
    required this.abNegative,
    required this.oPositive,
    required this.oNegative,
  });

  // From JSON
  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      bankId: json['bankId'],
      aPositive: BloodType.fromMap(json['APositive']),
      aNegative: BloodType.fromMap(json['ANegative']),
      bPositive: BloodType.fromMap(json['BPositive']),
      bNegative: BloodType.fromMap(json['BNegative']),
      abPositive: BloodType.fromMap(json['ABPositive']),
      abNegative: BloodType.fromMap(json['ABNegative']),
      oPositive: BloodType.fromMap(json['OPositive']),
      oNegative: BloodType.fromMap(json['ONegative']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'bankId': bankId,
      'APositive': aPositive.toMap(),
      'ANegative': aNegative.toMap(),
      'BPositive': bPositive.toMap(),
      'BNegative': bNegative.toMap(),
      'ABPositive': abPositive.toMap(),
      'ABNegative': abNegative.toMap(),
      'OPositive': oPositive.toMap(),
      'ONegative': oNegative.toMap(),
    };
  }

  @override
  String toString() {
    return 'Inventory(bankId: $bankId, APositive: $aPositive, ANegative: $aNegative, BPositive: $bPositive, BNegative: $bNegative, ABPositive: $abPositive, ABNegative: $abNegative, OPositive: $oPositive, ONegative: $oNegative)';
  }
}

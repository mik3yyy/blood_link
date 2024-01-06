// BloodType model
class BloodType {
  final String symbol;
  final String name;
  final int pints;
  final String unit;

  // Constructor
  BloodType({
    required this.symbol,
    required this.name,
    required this.pints,
    required this.unit,
  });

  // From Map
  factory BloodType.fromMap(Map<String, dynamic> map) {
    return BloodType(
      symbol: map['symbol'],
      name: map['name'],
      pints: map['pints'],
      unit: map['units'],
    );
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'symbol': symbol,
      'name': name,
      'pints': pints,
      'units': unit,
    };
  }

  @override
  String toString() {
    return 'BloodType(symbol: $symbol, name: $name, pints: $pints, unit: $unit)';
  }
}

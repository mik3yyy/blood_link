// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bankAdapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodBankAdapter extends TypeAdapter<BloodBank> {
  @override
  final int typeId = 2;

  @override
  BloodBank read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodBank(
      bankName: fields[0] as String,
      bankId: fields[1] as String,
      latitude: fields[2] as String,
      longitude: fields[3] as String,
      address: fields[4] as String,
      email: fields[5] as String,
      password: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BloodBank obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.bankName)
      ..writeByte(1)
      ..write(obj.bankId)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodBankAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donorAdapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DonorAdapter extends TypeAdapter<Donor> {
  @override
  final int typeId = 1;

  @override
  Donor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Donor(
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      bloodType: fields[2] as String,
      dateOfBirth: fields[3] as DateTime,
      phoneNumber: fields[4] as String,
      gender: fields[5] as String,
      email: fields[6] as String,
      password: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Donor obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.bloodType)
      ..writeByte(3)
      ..write(obj.dateOfBirth)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

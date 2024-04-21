// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_account_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountModelAdapter extends TypeAdapter<AccountModel> {
  @override
  final int typeId = 8;

  @override
  AccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountModel(
      phoneNumber: fields[0] as String?,
      id: fields[1] as String?,
      fname: fields[2] as String?,
      lname: fields[3] as String?,
      email: fields[5] as String?,
      gender: fields[4] as String?,
      role: fields[7] as String?,
      dob: fields[6] as String?,
      emailVerifiedAt: fields[8] as String?,
      phoneVerifiedAt: fields[9] as String?,
      completedForToday: fields[10] as num?,
      latitude: fields[11] as double?,
      longitude: fields[12] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.phoneNumber)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.fname)
      ..writeByte(3)
      ..write(obj.lname)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.dob)
      ..writeByte(7)
      ..write(obj.role)
      ..writeByte(8)
      ..write(obj.emailVerifiedAt)
      ..writeByte(9)
      ..write(obj.phoneVerifiedAt)
      ..writeByte(10)
      ..write(obj.completedForToday)
      ..writeByte(11)
      ..write(obj.latitude)
      ..writeByte(12)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_address_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressModelAdapter extends TypeAdapter<AddressModel> {
  @override
  final int typeId = 5;

  @override
  AddressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressModel(
      userId: fields[0] as String?,
      id: fields[1] as String?,
      label: fields[2] as String?,
      streetAddress: fields[3] as String?,
      apartmentNumber: fields[4] as String?,
      city: fields[5] as String?,
      state: fields[6] as String?,
      postalCode: fields[7] as String?,
      metadata: fields[11] as AddressSearchResponse?,
      createdAt: fields[8] as String?,
      updatedAt: fields[9] as String?,
      deletedAt: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AddressModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.streetAddress)
      ..writeByte(4)
      ..write(obj.apartmentNumber)
      ..writeByte(5)
      ..write(obj.city)
      ..writeByte(6)
      ..write(obj.state)
      ..writeByte(7)
      ..write(obj.postalCode)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.deletedAt)
      ..writeByte(11)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

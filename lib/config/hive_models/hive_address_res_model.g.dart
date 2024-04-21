// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_address_res_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressSearchResponseAdapter extends TypeAdapter<AddressSearchResponse> {
  @override
  final int typeId = 6;

  @override
  AddressSearchResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressSearchResponse(
      placeId: fields[0] as String?,
      description: fields[1] as String?,
      city: fields[2] as String?,
      region: fields[3] as String?,
      streetAddress: fields[4] as String?,
      postal: fields[5] as String?,
      streetNumber: fields[6] as int?,
      latitude: fields[7] as double?,
      longitude: fields[8] as double?,
      elevation: fields[9] as double?,
      geoNumber: fields[10] as int?,
      distance: fields[11] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, AddressSearchResponse obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.placeId)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.region)
      ..writeByte(4)
      ..write(obj.streetAddress)
      ..writeByte(5)
      ..write(obj.postal)
      ..writeByte(6)
      ..write(obj.streetNumber)
      ..writeByte(7)
      ..write(obj.latitude)
      ..writeByte(8)
      ..write(obj.longitude)
      ..writeByte(9)
      ..write(obj.elevation)
      ..writeByte(10)
      ..write(obj.geoNumber)
      ..writeByte(11)
      ..write(obj.distance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressSearchResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

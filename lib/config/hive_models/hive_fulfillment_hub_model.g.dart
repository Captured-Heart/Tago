// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_fulfillment_hub_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FulfillmentHubModelAdapter extends TypeAdapter<FulfillmentHubModel> {
  @override
  final int typeId = 2;

  @override
  FulfillmentHubModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FulfillmentHubModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      address: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FulfillmentHubModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FulfillmentHubModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

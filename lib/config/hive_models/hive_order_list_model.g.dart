// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_order_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderListModelAdapter extends TypeAdapter<OrderListModel> {
  @override
  final int typeId = 4;

  @override
  OrderListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderListModel(
      id: fields[0] as String?,
      riderId: fields[1] as String?,
      name: fields[2] as String?,
      address: fields[3] as AddressModel?,
      fulfillmentHub: fields[4] as FulfillmentHubModel?,
      user: fields[5] as AccountModel?,
      deliveryType: fields[6] as String?,
      paymentMethod: fields[7] as String?,
      instructions: fields[8] as String?,
      itemsTotalAmount: fields[9] as int?,
      fee: fields[10] as int?,
      totalAmount: fields[11] as int?,
      voucherCode: fields[12] as String?,
      discountPerc: fields[13] as double?,
      discountAmount: fields[14] as int?,
      scheduleForDate: fields[15] as String?,
      scheduleForTime: fields[16] as int?,
      placedAt: fields[17] as String?,
      receivedAt: fields[18] as String?,
      confirmedAt: fields[19] as String?,
      cancelledAt: fields[20] as String?,
      pickedUpAt: fields[21] as String?,
      deliveredAt: fields[22] as String?,
      currentPosition: fields[23] as String?,
      rider: fields[24] as AccountModel?,
      updatedAt: fields[25] as String?,
      deletedAt: fields[26] as String?,
      orderItems: (fields[27] as List?)?.cast<OrderItemModel>(),
      status: fields[28] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, OrderListModel obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.riderId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.fulfillmentHub)
      ..writeByte(5)
      ..write(obj.user)
      ..writeByte(6)
      ..write(obj.deliveryType)
      ..writeByte(7)
      ..write(obj.paymentMethod)
      ..writeByte(8)
      ..write(obj.instructions)
      ..writeByte(9)
      ..write(obj.itemsTotalAmount)
      ..writeByte(10)
      ..write(obj.fee)
      ..writeByte(11)
      ..write(obj.totalAmount)
      ..writeByte(12)
      ..write(obj.voucherCode)
      ..writeByte(13)
      ..write(obj.discountPerc)
      ..writeByte(14)
      ..write(obj.discountAmount)
      ..writeByte(15)
      ..write(obj.scheduleForDate)
      ..writeByte(16)
      ..write(obj.scheduleForTime)
      ..writeByte(17)
      ..write(obj.placedAt)
      ..writeByte(18)
      ..write(obj.receivedAt)
      ..writeByte(19)
      ..write(obj.confirmedAt)
      ..writeByte(20)
      ..write(obj.cancelledAt)
      ..writeByte(21)
      ..write(obj.pickedUpAt)
      ..writeByte(22)
      ..write(obj.deliveredAt)
      ..writeByte(23)
      ..write(obj.currentPosition)
      ..writeByte(24)
      ..write(obj.rider)
      ..writeByte(25)
      ..write(obj.updatedAt)
      ..writeByte(26)
      ..write(obj.deletedAt)
      ..writeByte(27)
      ..write(obj.orderItems)
      ..writeByte(28)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

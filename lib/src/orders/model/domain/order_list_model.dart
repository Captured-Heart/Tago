import 'package:equatable/equatable.dart';

class OrderListModel extends Equatable {
  final String? id;
  final String? name;
  final String? userId;
  final String? addressId;
  final String? deliveryType;
  final String? paymentMethod;
  final String? instructions;
  final int? itemsTotalAmount;
  final int? fee;
  final int? totalAmount;
  final String? voucherCode;
  final double? discountPerc;
  final int? discountAmount;
  final String? scheduleForDate;
  final int? scheduleForTime;
  final String? placedAt;
  final String? receivedAt;
  final String? confirmedAt;
  final String? cancelledAt;
  final String? pickedUpAt;
  final String? deliveredAt;
  final String? currentPosition;
  final String? riderId;
  final String? updatedAt;
  final String? deletedAt;
  final List<dynamic>? orderItems;
  final int? status;
  final String? fulfillmentHubId;

  const OrderListModel({
    this.id,
    this.name,
    this.userId,
    this.addressId,
    this.deliveryType,
    this.paymentMethod,
    this.instructions,
    this.itemsTotalAmount,
    this.fee,
    this.totalAmount,
    this.voucherCode,
    this.discountPerc,
    this.discountAmount,
    this.scheduleForDate,
    this.scheduleForTime,
    this.placedAt,
    this.receivedAt,
    this.confirmedAt,
    this.cancelledAt,
    this.pickedUpAt,
    this.deliveredAt,
    this.currentPosition,
    this.riderId,
    this.updatedAt,
    this.deletedAt,
    this.orderItems,
    this.status,
    this.fulfillmentHubId,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      userId: json['userId'] as String?,
      addressId: json['addressId'] as String?,
      deliveryType: json['deliveryType'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      instructions: json['instructions'] as String?,
      itemsTotalAmount: json['itemsTotalAmount'] as int?,
      fee: json['fee'] as int?,
      totalAmount: json['totalAmount'] as int?,
      voucherCode: json['voucherCode'] as String?,
      discountPerc: (json['discountPerc'] as num?)?.toDouble(),
      discountAmount: json['discountAmount'] as int?,
      scheduleForDate: json['scheduleForDate'] as String?,
      scheduleForTime: json['scheduleForTime'] as int?,
      placedAt: json['placedAt'] as String?,
      receivedAt: json['receivedAt'] as String?,
      confirmedAt: json['confirmedAt'] as String?,
      cancelledAt: json['cancelledAt'] as String?,
      pickedUpAt: json['pickedUpAt'] as String?,
      deliveredAt: json['deliveredAt'] as String?,
      currentPosition: json['currentPosition'] as String?,
      riderId: json['riderId'] as String?,
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      orderItems: json['orderItems'] as List<dynamic>?,
      status: json['status'] as int?,
      fulfillmentHubId: json['fulfillmentHubId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'userId': userId,
        'addressId': addressId,
        'deliveryType': deliveryType,
        'paymentMethod': paymentMethod,
        'instructions': instructions,
        'itemsTotalAmount': itemsTotalAmount,
        'fee': fee,
        'totalAmount': totalAmount,
        'voucherCode': voucherCode,
        'discountPerc': discountPerc,
        'discountAmount': discountAmount,
        'scheduleForDate': scheduleForDate,
        'scheduleForTime': scheduleForTime,
        'placedAt': placedAt,
        'receivedAt': receivedAt,
        'confirmedAt': confirmedAt,
        'cancelledAt': cancelledAt,
        'pickedUpAt': pickedUpAt,
        'deliveredAt': deliveredAt,
        'currentPosition': currentPosition,
        'riderId': riderId,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
        'orderItems': orderItems,
        'status': status,
        'fulfillmentHubId': fulfillmentHubId,
      };

  OrderListModel copyWith({
    String? id,
    String? name,
    String? userId,
    String? addressId,
    String? deliveryType,
    String? paymentMethod,
    String? instructions,
    int? itemsTotalAmount,
    int? fee,
    int? totalAmount,
    String? voucherCode,
    double? discountPerc,
    int? discountAmount,
    String? scheduleForDate,
    int? scheduleForTime,
    String? placedAt,
    String? receivedAt,
    String? confirmedAt,
    String? cancelledAt,
    String? pickedUpAt,
    String? deliveredAt,
    String? currentPosition,
    String? riderId,
    String? updatedAt,
    String? deletedAt,
    List<dynamic>? orderItems,
    int? status,
    String? fulfillmentHubId,
  }) {
    return OrderListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      addressId: addressId ?? this.addressId,
      deliveryType: deliveryType ?? this.deliveryType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      instructions: instructions ?? this.instructions,
      itemsTotalAmount: itemsTotalAmount ?? this.itemsTotalAmount,
      fee: fee ?? this.fee,
      totalAmount: totalAmount ?? this.totalAmount,
      voucherCode: voucherCode ?? this.voucherCode,
      discountPerc: discountPerc ?? this.discountPerc,
      discountAmount: discountAmount ?? this.discountAmount,
      scheduleForDate: scheduleForDate ?? this.scheduleForDate,
      scheduleForTime: scheduleForTime ?? this.scheduleForTime,
      placedAt: placedAt ?? this.placedAt,
      receivedAt: receivedAt ?? this.receivedAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      pickedUpAt: pickedUpAt ?? this.pickedUpAt,
      deliveredAt: deliveredAt ?? this.deliveredAt,
      currentPosition: currentPosition ?? this.currentPosition,
      riderId: riderId ?? this.riderId,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      orderItems: orderItems ?? this.orderItems,
      status: status ?? this.status,
      fulfillmentHubId: fulfillmentHubId ?? this.fulfillmentHubId,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      userId,
      addressId,
      deliveryType,
      paymentMethod,
      instructions,
      itemsTotalAmount,
      fee,
      totalAmount,
      voucherCode,
      discountPerc,
      discountAmount,
      scheduleForDate,
      scheduleForTime,
      placedAt,
      receivedAt,
      confirmedAt,
      cancelledAt,
      pickedUpAt,
      deliveredAt,
      currentPosition,
      riderId,
      updatedAt,
      deletedAt,
      orderItems,
      status,
      fulfillmentHubId,
    ];
  }
}

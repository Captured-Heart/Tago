import 'package:tago/app.dart';

class OrderListModel extends Equatable {
  final String? id;
  final String? riderId;
  final String? name;
  final AddressModel? address;
  final FulfillmentHubModel? fulfillmentHub;
  final AccountModel? user;
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
  final AccountModel? rider;
  final String? updatedAt;
  final String? deletedAt;
  final List<OrderItemModel>? orderItems;
  final int? status;

  const OrderListModel({
    this.id,
    this.riderId,
    this.name,
    this.address,
    this.fulfillmentHub,
    this.user,
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
    this.rider,
    this.updatedAt,
    this.deletedAt,
    this.orderItems,
    this.status,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      id: json['id'] as String?,
      riderId: json['riderId'] as String?,
      name: json['name'] as String?,
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
      rider:
          json['rider'] == null ? null : AccountModel.fromJson(json['rider']),
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      orderItems: json['orderItems'] == null
          ? null
          : (json['orderItems'] as List)
              .map((e) => OrderItemModel.fromJson(e))
              .toList(),
      status: json['status'] as int?,
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
      fulfillmentHub: json['fulfillmentHub'] != null
          ? FulfillmentHubModel.fromJson(json['fulfillmentHub'])
          : null,
      user: json['user'] == null
          ? null
          : AccountModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'riderId': riderId,
        'name': name,
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
        'rider': rider,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
        'orderItems': orderItems,
        'status': status,
        'user': user?.toJson(),
      };

  OrderListModel copyWith({
    String? id,
    String? riderId,
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
    AccountModel? rider,
    String? updatedAt,
    String? deletedAt,
    List<OrderItemModel>? orderItems,
    int? status,
    String? fulfillmentHubId,
  }) {
    return OrderListModel(
      id: id ?? this.id,
      riderId: id ?? this.riderId,
      name: name ?? this.name,
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
      rider: rider ?? this.rider,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      orderItems: orderItems ?? this.orderItems,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      address,
      fulfillmentHub,
      user,
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
      rider,
      updatedAt,
      deletedAt,
      orderItems,
      status,
    ];
  }
}

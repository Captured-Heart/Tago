import 'package:tago/app.dart';
part 'hive_order_list_model.g.dart';

@HiveType(typeId: 4)
class OrderListModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? riderId;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final AddressModel? address;
  @HiveField(4)
  final FulfillmentHubModel? fulfillmentHub;
  @HiveField(5)
  final AccountModel? user;
  @HiveField(6)
  final String? deliveryType;
  @HiveField(7)
  final String? paymentMethod;
  @HiveField(8)
  final String? instructions;
  @HiveField(9)
  final int? itemsTotalAmount;
  @HiveField(10)
  final int? fee;
  @HiveField(11)
  final int? totalAmount;
  @HiveField(12)
  final String? voucherCode;
  @HiveField(13)
  final double? discountPerc;
  @HiveField(14)
  final int? discountAmount;
  @HiveField(15)
  final String? scheduleForDate;
  @HiveField(16)
  final int? scheduleForTime;
  @HiveField(17)
  final String? placedAt;
  @HiveField(18)
  final String? receivedAt;
  @HiveField(19)
  final String? confirmedAt;
  @HiveField(20)
  final String? cancelledAt;
  @HiveField(21)
  final String? pickedUpAt;
  @HiveField(22)
  final String? deliveredAt;
  @HiveField(23)
  final String? currentPosition;
  @HiveField(24)
  final AccountModel? rider;
  @HiveField(25)
  final String? updatedAt;
  @HiveField(26)
  final String? deletedAt;
  @HiveField(27)
  final List<OrderItemModel>? orderItems;
  @HiveField(28)
  int? status;

  OrderListModel({
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
}
  // final String? id;
  // final String? riderId;
  // final String? name;
  // final AddressModel? address;
  // final FulfillmentHubModel? fulfillmentHub;
  // final AccountModel? user;
  // final String? deliveryType;
  // final String? paymentMethod;
  // final String? instructions;
  // final int? itemsTotalAmount;
  // final int? fee;
  // final int? totalAmount;
  // final String? voucherCode;
  // final double? discountPerc;
  // final int? discountAmount;
  // final String? scheduleForDate;
  // final int? scheduleForTime;
  // final String? placedAt;
  // final String? receivedAt;
  // final String? confirmedAt;
  // final String? cancelledAt;
  // final String? pickedUpAt;
  // final String? deliveredAt;
  // final String? currentPosition;
  // final AccountModel? rider;
  // final String? updatedAt;
  // final String? deletedAt;
  // final List<OrderItemModel>? orderItems;
  // final int? status;
import 'package:tago/app.dart';


class OrderModel extends Equatable {
  final String? id;
  final String? name;
  final AddressModel? address;
  final FulfillmentHubModel? fulfillmentHub;
  final List<dynamic>? orderItems;
  final AccountModel? user;

  const OrderModel({
    this.id,
    this.name,
    this.address,
    this.fulfillmentHub,
    this.orderItems,
    this.user,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] as String?,
        name: json['name'] as String?,
        address: json['address'] == null
            ? null
            : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
        fulfillmentHub: json['fulfillmentHub'] == null
            ? null
            : FulfillmentHubModel.fromJson(
                json['fulfillmentHub'] as Map<String, dynamic>),
        orderItems: json['orderItems'] as List<dynamic>?,
        user: json['user'] == null
            ? null
            : AccountModel.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address?.toJson(),
        'fulfillmentHub': fulfillmentHub?.toJson(),
        'orderItems': orderItems,
        'user': user?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      address,
      fulfillmentHub,
      orderItems,
      user,
    ];
  }
}

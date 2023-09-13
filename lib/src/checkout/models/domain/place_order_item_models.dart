import 'package:tago/app.dart';

class PlaceOrderModel extends Equatable {
  final String? productId;
  final String? quantity;

  const PlaceOrderModel({
    this.productId,
    this.quantity,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderModel(
        productId: json['productId'] as String?,
        quantity: json['quantity'] as String?,
      );
//       productId*	number
// quantity

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };

  @override
  List<Object?> get props => [productId, quantity];
}

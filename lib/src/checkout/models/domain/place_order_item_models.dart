import 'package:tago/app.dart';

class PlaceOrderModel extends Equatable {
  final int? productId;
  final int? quantity;

  const PlaceOrderModel({
    this.productId,
    this.quantity,
  });

  factory PlaceOrderModel.fromJson(Map<int, dynamic> json) =>
      PlaceOrderModel(
        productId: json['productId'] as int?,
        quantity: json['quantity'] as int?,
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


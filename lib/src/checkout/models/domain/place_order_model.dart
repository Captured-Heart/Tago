import 'package:tago/app.dart';

class PlaceOrderModel extends Equatable {
  final int? amount;
  final int? quantity;
  final ProductsModel? product;
  final String? productId;

  const PlaceOrderModel({
    this.amount,
    this.quantity,
    this.product,
    this.productId,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    return PlaceOrderModel(
        amount: json['amount'] as int?,
        quantity: json['quantity'] as int?,
        product: json['product'] == null
            ? null
            : ProductsModel.fromJson(json['product'] as Map<String, dynamic>),
        productId: json['productId'] as String?);
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'quantity': quantity,
        'product': product?.toJson(),
        'productId': productId,
      };

  PlaceOrderModel copyWith({
    int? amount,
    int? quantity,
    ProductsModel? product,
    String? productId,
  }) {
    return PlaceOrderModel(
      amount: amount ?? this.amount,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
      productId: productId ?? this.productId,
    );
  }

  @override
  List<Object?> get props => [
        amount,
        quantity,
        product,
        productId,
      ];
}

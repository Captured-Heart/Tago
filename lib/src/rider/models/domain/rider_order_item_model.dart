import 'package:tago/app.dart';

class OrderItemModel extends Equatable {
  final int? amount;
  final int? quantity;
  final ProductsModel? product;

  const OrderItemModel({
    this.amount,
    this.quantity,
    this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      amount: json['amount'] as int?,
      quantity: json['quantity'] as int?,
      product: json['product'] == null
          ? null
          : ProductsModel.fromJson(json['product'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'quantity': quantity,
        'product': product?.toJson(),
      };

  OrderItemModel copyWith({
    int? amount,
    int? quantity,
    ProductsModel? product,
  }) {
    return OrderItemModel(
      amount: amount ?? this.amount,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [
        amount,
        quantity,
        product,
      ];
}

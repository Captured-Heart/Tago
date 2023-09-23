import 'package:tago/app.dart';

class RiderOrderItemsModel extends Equatable {
  final int? amount;
  final int? quantity;
  final ProductsModel? product;

  const RiderOrderItemsModel({
    this.amount,
    this.quantity,
    this.product,
  });

  factory RiderOrderItemsModel.fromJson(Map<String, dynamic> json) {
    return RiderOrderItemsModel(
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

  RiderOrderItemsModel copyWith({
    int? amount,
    int? quantity,
    ProductsModel? product,
  }) {
    return RiderOrderItemsModel(
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

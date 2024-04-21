import 'package:tago/app.dart';
part 'hive_order_item_model.g.dart';

@HiveType(typeId: 7)
class OrderItemModel extends HiveObject {
  @HiveField(0)
  final int? amount;
  @HiveField(1)
  final int? quantity;
  @HiveField(2)
  final ProductsModel? product;

  OrderItemModel({
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
}

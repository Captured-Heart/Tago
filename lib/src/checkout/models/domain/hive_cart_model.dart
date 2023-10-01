import 'package:tago/app.dart';

import 'package:hive/hive.dart';
part 'hive_cart_model.g.dart';

@HiveType(typeId: 2)
class CartModel {
  @HiveField(0)
  int? quantity;
  @HiveField(1)
  ProductsModel? product;

  CartModel({this.quantity, this.product});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        quantity: json['quantity'] as int?,
        product: json['product'] == null
            ? null
            : ProductsModel.fromJson(json['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'product': product?.toJson(),
      };

  CartModel copyWith({
    int? quantity,
    ProductsModel? product,
  }) {
    return CartModel(
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }
}

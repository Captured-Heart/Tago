import 'package:tago/app.dart';

class CartModel extends Equatable {
  final int? quantity;
  final ProductsModel? product;

  const CartModel({this.quantity, this.product});

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

  @override
  List<Object?> get props => [quantity, product];
}

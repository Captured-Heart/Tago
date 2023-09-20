import 'package:tago/app.dart';

// ignore: must_be_immutable
class CartModel extends Equatable {
  int? quantity;
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

  @override
  List<Object?> get props => [quantity, product];
}


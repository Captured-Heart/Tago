class PlaceOrderModel {
  final String? productId;
  final String? quantity;

  const PlaceOrderModel({
    this.productId,
    this.quantity,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) => PlaceOrderModel(
        productId: json['productId'] as String?,
        quantity: json['quantity'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };
}

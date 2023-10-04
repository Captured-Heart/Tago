import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  final String id;
  final String last4;
  final String brand;
  final String expiryMonth;
  final String expiryYear;

  const CardModel({
    required this.id,
    required this.brand,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json['id'] as String,
        last4: json['last4Digit'] as String,
        brand: json['brand'] as String,
        expiryMonth: json['expiryMonth'] as String,
        expiryYear: json['expiryYear'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand': brand,
        'last4Digit': last4,
        'expiryMonth': expiryMonth,
        'expiryYear': expiryYear,
      };

  @override
  List<Object?> get props {
    return [
      id,
      brand,
      last4,
      expiryMonth,
      expiryYear,
    ];
  }
}

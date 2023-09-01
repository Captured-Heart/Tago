import 'package:equatable/equatable.dart';

class ProductsModel extends Equatable {
  final String? name;
  final int? id;
  final String? label;
  final List<dynamic>? productImages;
  final int? categoryId;
  final int? subCategoryId;
  final int? amount;
  final int? originalAmount;
  final double? savedPerc;
  final int? availableQuantity;

  const ProductsModel({
    this.name,
    this.id,
    this.label,
    this.productImages,
    this.categoryId,
    this.subCategoryId,
    this.amount,
    this.originalAmount,
    this.savedPerc,
    this.availableQuantity,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        name: json['name'] as String?,
        id: json['id'] as int?,
        label: json['label'] as String?,
        productImages: json['productImages'] as List<dynamic>?,
        categoryId: json['categoryId'] as int?,
        subCategoryId: json['subCategoryId'] as int?,
        amount: json['amount'] as int?,
        originalAmount: json['originalAmount'] as int?,
        savedPerc: json['savedPerc'] as double?,
        availableQuantity: json['availableQuantity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'label': label,
        'productImages': productImages,
        'categoryId': categoryId,
        'subCategoryId': subCategoryId,
        'amount': amount,
        'originalAmount': originalAmount,
        'savedPerc': savedPerc,
        'availableQuantity': availableQuantity,
      };

  @override
  List<Object?> get props {
    return [
      name,
      id,
      label,
      productImages,
      categoryId,
      subCategoryId,
      amount,
      originalAmount,
      savedPerc,
      availableQuantity,
    ];
  }
}

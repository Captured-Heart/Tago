import 'package:equatable/equatable.dart';

class ProductsModel extends Equatable {
  final String? name;
  final int? id;
  final String? label;
  final String? description;
  final List<dynamic>? productImages,
      productSpecification,
      productReview,
      productTags,
      relatedProducts;
  final int? categoryId;
  final int? subCategoryId;
  final int? amount;
  final String? brand;
  final Map<String, dynamic>? category, subCategory;
  final int? originalAmount;
  final double? savedPerc;
  final int? availableQuantity;

  const ProductsModel({
    this.name,
    this.id,
    this.label,
    this.productImages,
    this.productSpecification,
    this.categoryId,
    this.subCategoryId,
    this.amount,
    this.brand,
    this.originalAmount,
    this.savedPerc,
    this.availableQuantity,
    this.description,
    //
    this.category,
    this.productReview,
    this.productTags,
    this.relatedProducts,
    this.subCategory,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        name: json['name'] as String?,
        id: json['id'] as int?,
        label: json['label'] as String?,
        description: json['description'] as String?,
        productImages: json['productImages'] as List<dynamic>?,
        productSpecification: json['productSpecification'] as List<dynamic>?,
        categoryId: json['categoryId'] as int?,
        subCategoryId: json['subCategoryId'] as int?,
        amount: json['amount'] as int?,
        brand: json['brandId'] as String?,
        originalAmount: json['originalAmount'] as int?,
        savedPerc: json['savedPerc'] as double?,
        availableQuantity: json['availableQuantity'] as int?,
        category: json['category'] as Map<String, dynamic>?,
        subCategory: json['subCategory'] as Map<String, dynamic>?,
        productReview: json['productReview'] as List<dynamic>?,
        productTags: json['productTags'] as List<dynamic>?,
        relatedProducts: json['relatedProducts'] as List<dynamic>?,
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
        'description': description,
        'brand': brand,
        'productSpecification': productSpecification,
        'availableQuantity': availableQuantity,
        //
        'category': category,
        'subCategory': subCategory,
        'productReview': productReview,
        'productTags': productTags,
        'relatedProducts': relatedProducts,
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
      productSpecification,
      description,
      brand,
      category,
      subCategory,
      productReview,
      productTags,
      relatedProducts,
    ];
  }
}

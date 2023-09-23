import 'package:tago/app.dart';

class ProductsModel extends Equatable {
  final int? id;
  final String? name;
  final String? label;
  final String? description;
  final List<dynamic>? productImages;
  final List<dynamic>? productSpecification;
  final List<dynamic>? productReview;
  final List<dynamic>? productTags;
  final List<dynamic>? relatedProducts;
  final int? categoryId;
  final int? subCategoryId;
  final int? amount;
  final String? brand;
  final CategoriesModel? category;
  final SubCategoriesModel? subCategory;
  final int? originalAmount;
  final double? savedPerc;
  final int? availableQuantity;

  const ProductsModel({
    this.id,
    this.name,
    this.label,
    this.description,
    this.productImages,
    this.productSpecification,
    this.productReview,
    this.productTags,
    this.relatedProducts,
    this.categoryId,
    this.subCategoryId,
    this.amount,
    this.brand,
    this.category,
    this.subCategory,
    this.originalAmount,
    this.savedPerc,
    this.availableQuantity,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        label: json['label'] as String?,
        description: json['description'] as String?,
        productImages: json['productImages'] as List<dynamic>?,
        productSpecification: json['productSpecification'] as List<dynamic>?,
        productReview: json['productReview'] as List<dynamic>?,
        productTags: json['productTags'] as List<dynamic>?,
        relatedProducts: json['relatedProducts'] as List<dynamic>?,
        categoryId: json['categoryId'] as int?,
        subCategoryId: json['subCategoryId'] as int?,
        amount: json['amount'] as int?,
        brand: json['brand'] as String?,
        category: json['category'] == null
            ? null
            : CategoriesModel.fromJson(
                json['category'] as Map<String, dynamic>),
        subCategory: json['subCategory'] == null
            ? null
            : SubCategoriesModel.fromJson(
                json['subCategory'] as Map<String, dynamic>),
        originalAmount: json['originalAmount'] as int?,
        savedPerc: (json['savedPerc'] as num?)?.toDouble(),
        availableQuantity: json['availableQuantity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'label': label,
        'description': description,
        'productImages': productImages,
        'productSpecification': productSpecification,
        'productReview': productReview,
        'productTags': productTags,
        'relatedProducts': relatedProducts,
        'categoryId': categoryId,
        'subCategoryId': subCategoryId,
        'amount': amount,
        'brand': brand,
        'category': category?.toJson(),
        'subCategory': subCategory?.toJson(),
        'originalAmount': originalAmount,
        'savedPerc': savedPerc,
        'availableQuantity': availableQuantity,
      };

  ProductsModel copyWith({
    int? id,
    String? name,
    String? label,
    String? description,
    List<dynamic>? productImages,
    List<dynamic>? productSpecification,
    List<dynamic>? productReview,
    List<dynamic>? productTags,
    List<dynamic>? relatedProducts,
    int? categoryId,
    int? subCategoryId,
    int? amount,
    String? brand,
    CategoriesModel? category,
    SubCategoriesModel? subCategory,
    int? originalAmount,
    double? savedPerc,
    int? availableQuantity,
  }) {
    return ProductsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      label: label ?? this.label,
      description: description ?? this.description,
      productImages: productImages ?? this.productImages,
      productSpecification: productSpecification ?? this.productSpecification,
      productReview: productReview ?? this.productReview,
      productTags: productTags ?? this.productTags,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      amount: amount ?? this.amount,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      originalAmount: originalAmount ?? this.originalAmount,
      savedPerc: savedPerc ?? this.savedPerc,
      availableQuantity: availableQuantity ?? this.availableQuantity,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      label,
      description,
      productImages,
      productSpecification,
      productReview,
      productTags,
      relatedProducts,
      categoryId,
      subCategoryId,
      amount,
      brand,
      category,
      subCategory,
      originalAmount,
      savedPerc,
      availableQuantity,
    ];
  }
}

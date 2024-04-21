// import 'package:tago/app.dart';
import 'package:tago/app.dart';
part 'hive_product_model.g.dart';

@HiveType(typeId: 1)
class ProductsModel extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? label;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final List<dynamic>? productImages;
  @HiveField(5)
  final List<dynamic>? productSpecification;
  @HiveField(6)
  final List<dynamic>? productReview;
  @HiveField(7)
  final List<dynamic>? productTags;
  @HiveField(8)
  final List<dynamic>? relatedProducts;
  @HiveField(9)
  final int? categoryId;
  @HiveField(10)
  final int? subCategoryId;
  @HiveField(11)
  final int? amount;
  @HiveField(12)
  final Map<String, dynamic>? brand;
  @HiveField(13)
  final CategoriesModel? category;
  @HiveField(14)
  final SubCategoriesModel? subCategory;
  @HiveField(15)
  final int? originalAmount;
  @HiveField(16)
  final double? savedPerc;
  @HiveField(17)
  final int? availableQuantity;
  @HiveField(18)
  final DateTime? date;

  ProductsModel({
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
    this.date,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        label: json['label'] as String?,
        description: json['description'] as String?,
        productImages: json['productImages'] as List<dynamic>?,
        productSpecification: json['productSpecification'] as List<dynamic>?,
        productReview: json['productReview'] as List<dynamic>?,
        relatedProducts: json['relatedProducts'] as List<dynamic>?,
        amount: json['amount'] as int?,
        originalAmount: json['originalAmount'] as int?,
        savedPerc: (json['savedPerc'] as num?)?.toDouble(),
        availableQuantity: json['availableQuantity'] as int?,
        date: json['date'] as DateTime?,
        // productTags: json['productTags'] as List<dynamic>?,
        // subCategoryId: json['subCategoryId'] as int?,
        // categoryId: json['categoryId'] as int?,
        // brand: json['brand'] as String?,
        // category: json['category'] == null
        //     ? null
        //     : CategoriesModel.fromJson(
        //         json['category'] as Map<String, dynamic>),
        // subCategory: json['subCategory'] == null
        //     ? null
        //     : SubCategoriesModel.fromJson(
        //         json['subCategory'] as Map<String, dynamic>),
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
        'date': DateTime.now(),
      };
}

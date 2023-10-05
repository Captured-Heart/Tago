import 'package:tago/app.dart';

class CategoriesModel extends Equatable {
  final String? name;
  final int? id;
  final String? label;
  final Map<String, dynamic>? image;
  final List<SubCategoryModel>? subCategories;
  final List<dynamic>? products;

  const CategoriesModel({
    this.name,
    this.id,
    this.label,
    this.image,
    this.subCategories,
    this.products,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
        name: json['name'] as String?,
        id: json['id'] as int?,
        label: json['label'] as String?,
        image: json['image'] as Map<String, dynamic>?,
        products: json['products'] as List<dynamic>?,
        subCategories: (json['subCategories'] as List)
            .map((e) => SubCategoryModel.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'label': label,
        'image': image,
        'subCategories': subCategories,
        'products': products,
      };

  @override
  List<Object?> get props => [name, id, label, image, subCategories, products];
}

class CategoriesGroupModel extends Equatable {
  final List<CategoriesModel> categories;
  final List<DealsModel> deals;
  final ProductTagModel? showcaseProductTag;

  const CategoriesGroupModel(
      {required this.categories, required this.deals, this.showcaseProductTag});

  @override
  List<Object?> get props => [categories, deals];
}

class SubCategoryModel extends Equatable {
  final String name;
  final int id;
  final int categoryId;
  final String label;
  final String? imageUrl;
  final List<ProductsModel>? products;

  const SubCategoryModel(
      {required this.name,
      required this.id,
      required this.categoryId,
      required this.label,
      this.imageUrl,
      this.products});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
        name: json['name'] as String,
        id: json['id'] as int,
        categoryId: json['categoryId'] as int,
        label: json['label'] as String,
        imageUrl: json['image']['url'] as String?,
        products: json['products'] != null
            ? (json['products'] as List)
                .map((e) => ProductsModel.fromJson(e))
                .toList()
            : null);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'categoryId': categoryId,
        'label': label,
        'products': products,
        'imageUrl': imageUrl,
      };

  @override
  List<Object?> get props => [name, id, categoryId, label, imageUrl, products];
}

class DealsModel extends Equatable {
  final String? name;
  final int? id;
  final String? label;
  final ProductTagModel? tag;
  final String? imageUrl;

  const DealsModel({
    this.name,
    this.id,
    this.label,
    this.imageUrl,
    this.tag,
  });

  factory DealsModel.fromJson(Map<String, dynamic> json) {
    return DealsModel(
        name: json['name'] as String?,
        id: json['id'] as int?,
        label: json['label'] as String?,
        imageUrl:
            json['image'] != null ? json['image']['url'] as String? : null,
        tag:
            json['tag'] != null ? ProductTagModel.fromJson(json['tag']) : null);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'label': label,
        'tag': tag,
        'imageUrl': imageUrl,
      };

  @override
  List<Object?> get props => [name, id, label, imageUrl, tag];
}

class ProductTagModel extends Equatable {
  final String name;
  final int id;
  final String label;
  final String? imageUrl;
  final String? previewImageUrl;

  final List<ProductsModel>? products;

  const ProductTagModel(
      {required this.name,
      required this.id,
      required this.label,
      this.imageUrl,
      this.previewImageUrl,
      this.products});

  factory ProductTagModel.fromJson(Map<String, dynamic> json) {
    return ProductTagModel(
        name: json['name'] as String,
        id: json['id'] as int,
        label: json['label'] as String,
        imageUrl:
            json['image'] != null ? json['image']['url'] as String? : null,
        previewImageUrl: json['previewImage'] != null
            ? json['previewImage']['url'] as String?
            : null,
        products: json['productTags'] != null
            ? (json['productTags'] as List)
                .map((e) => ProductsModel.fromJson(e['product']))
                .toList()
            : null);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'label': label,
        'products': products,
        'imageUrl': imageUrl,
      };

  @override
  List<Object?> get props => [name, id, label, imageUrl, products];
}

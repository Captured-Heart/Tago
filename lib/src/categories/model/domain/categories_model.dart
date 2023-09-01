import 'package:tago/app.dart';

class CategoriesModel extends Equatable {
  final String? name;
  final int? id;
  final String? label;
  final Map<String, dynamic>? image;
  final List<dynamic>? subCategories;
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
      subCategories: json['subCategories'] as List<dynamic>?,
      products: json['products'] as List<dynamic>?,
    );
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

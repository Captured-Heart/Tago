import 'package:tago/app.dart';

class CategoriesModel extends Equatable {
  final String? name;
  final int? id;
  final String? label;
  final String? imgUrl;
  final List<dynamic>? subCategories;
  final List<dynamic>? products;

  const CategoriesModel({
    this.name,
    this.id,
    this.label,
    this.imgUrl,
    this.subCategories,
    this.products,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      name: json['name'] as String?,
      id: json['id'] as int?,
      label: json['label'] as String?,
      imgUrl: json['imgUrl'] as String?,
      subCategories: json['subCategories'] as List<dynamic>?,
      products: json['products'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'label': label,
        'imgUrl': imgUrl,
        'subCategories': subCategories,
        'products': products,
      };

  @override
  List<Object?> get props => [name, id, label, imgUrl, subCategories, products];
}

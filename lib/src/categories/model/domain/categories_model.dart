import 'package:equatable/equatable.dart';

class CategoriesModel extends Equatable {
  final String? name;
  final int? id;
  final String? label;
  final String? imgUrl;
  final List<dynamic>? subCategories;

  const CategoriesModel({
    this.name,
    this.id,
    this.label,
    this.imgUrl,
    this.subCategories,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      name: json['name'] as String?,
      id: json['id'] as int?,
      label: json['label'] as String?,
      imgUrl: json['imgUrl'] as String?,
      subCategories: json['subCategories'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'label': label,
        'imgUrl': imgUrl,
        'subCategories': subCategories,
      };

  @override
  List<Object?> get props => [name, id, label, imgUrl, subCategories];
}

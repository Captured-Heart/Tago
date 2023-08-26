import 'package:equatable/equatable.dart';

class SubCategoriesModel extends Equatable {
  final String? name;
  final int? id;
  final String? label;
  final String? imgUrl;
  final int? categoryId;

  const SubCategoriesModel({
    this.name,
    this.id,
    this.label,
    this.imgUrl,
    this.categoryId,
  });

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    return SubCategoriesModel(
      name: json['name'] as String?,
      id: json['id'] as int?,
      label: json['label'] as String?,
      imgUrl: json['imgUrl'] as String?,
      categoryId: json['categoryId'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'label': label,
        'imgUrl': imgUrl,
        'categoryId': categoryId,
      };

  @override
  List<Object?> get props => [name, id, label, imgUrl, categoryId];
}
import 'package:equatable/equatable.dart';

class ProductSpecificationsModel extends Equatable {
  final int? id;
  final String? title;
  final String? value;

  const ProductSpecificationsModel({this.id, this.title, this.value});

  factory ProductSpecificationsModel.fromJson(Map<String, dynamic> json) {
    return ProductSpecificationsModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'value': value,
      };

  @override
  List<Object?> get props => [id, title, value];
}

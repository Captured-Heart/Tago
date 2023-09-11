import 'package:tago/app.dart';

class ProductReviewsModel extends Equatable {
  final int? id;
  final String? title;
  final num? rating;
  final String? review;
  final String? createdAt;
  final AccountModel? user;

  const ProductReviewsModel({
    this.id,
    this.title,
    this.rating,
    this.review,
    this.createdAt,
    this.user,
  });

  factory ProductReviewsModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewsModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      rating: json['rating'] as num?,
      review: json['review'] as String?,
      createdAt: json['createdAt'] as String?,
      user:
          json['user'] == null ? null : AccountModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'rating': rating,
        'review': review,
        'createdAt': createdAt,
        'user': user?.toJson(),
      };

  @override
  List<Object?> get props => [id, title, rating, review, createdAt, user];
}

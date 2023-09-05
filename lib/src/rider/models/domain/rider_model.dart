import 'package:tago/app.dart';

class RiderModel extends Equatable {
  final String? id;
  final String? status;
  final String? confirmedAt;
  final String? createdAt;
  final OrderModel? order;

  const RiderModel({
    this.id,
    this.status,
    this.confirmedAt,
    this.createdAt,
    this.order,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) => RiderModel(
        id: json['id'] as String?,
        status: json['status'] as String?,
        confirmedAt: json['confirmedAt'] as String?,
        createdAt: json['createdAt'] as String?,
        order: json['order'] == null
            ? null
            : OrderModel.fromJson(json['order'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'confirmedAt': confirmedAt,
        'createdAt': createdAt,
        'order': order?.toJson(),
      };

  @override
  List<Object?> get props => [id, status, confirmedAt, createdAt, order];
}

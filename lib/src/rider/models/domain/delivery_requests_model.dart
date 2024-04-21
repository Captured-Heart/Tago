import 'package:tago/app.dart';


class DeliveryRequestsModel extends Equatable {
  final String? id;
  final int? status;
  final String? confirmedAt;
  final String? createdAt;
  final OrderModel? order;

  const DeliveryRequestsModel({
    this.id,
    this.status,
    this.confirmedAt,
    this.createdAt,
    this.order,
  });

  factory DeliveryRequestsModel.fromJson(Map<String, dynamic> json) {
    return DeliveryRequestsModel(
      id: json['id'] as String?,
      status: json['status'] as int?,
      confirmedAt: json['confirmedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      order: json['order'] == null
          ? null
          : OrderModel.fromJson(json['order'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'confirmedAt': confirmedAt,
        'createdAt': createdAt,
        'order': order?.toJson(),
      };

  DeliveryRequestsModel copyWith({
    String? id,
    int? status,
    String? confirmedAt,
    String? createdAt,
    OrderModel? order,
  }) {
    return DeliveryRequestsModel(
      id: id ?? this.id,
      status: status ?? this.status,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      createdAt: createdAt ?? this.createdAt,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [id, status, confirmedAt, createdAt, order];
}

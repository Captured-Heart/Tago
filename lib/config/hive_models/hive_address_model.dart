import 'package:tago/app.dart';
part 'hive_address_model.g.dart';

@HiveType(typeId: 5)
class AddressModel extends HiveObject {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String? id;
  @HiveField(2)
  final String? label;
  @HiveField(3)
  final String? streetAddress;
  @HiveField(4)
  final String? apartmentNumber;
  @HiveField(5)
  final String? city;
  @HiveField(6)
  final String? state;
  @HiveField(7)
  final String? postalCode;
  @HiveField(8)
  final String? createdAt;
  @HiveField(9)
  final String? updatedAt;
  @HiveField(10)
  final String? deletedAt;
  @HiveField(11)
  final AddressSearchResponse? metadata;

  AddressModel({
    this.userId,
    this.id,
    this.label,
    this.streetAddress,
    this.apartmentNumber,
    this.city,
    this.state,
    this.postalCode,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        userId: json['userId'] as String?,
        id: json['id'] as String?,
        label: json['label'] as String?,
        streetAddress: json['streetAddress'] as String?,
        apartmentNumber: json['apartmentNumber'] as String?,
        city: json['city'] as String?,
        state: json['state'] as String?,
        postalCode: json['postalCode'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        deletedAt: json['deletedAt'] as String?,
        metadata: json['metadata'] != null
            ? AddressSearchResponse.fromJson(jsonDecode(json['metadata']))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'label': label,
        'streetAddress': streetAddress,
        'apartmentNumber': apartmentNumber,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'position': metadata,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
      };
}

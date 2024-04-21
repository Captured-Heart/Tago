import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tago/src/onboarding/model/domain/address_res.dart';

class AddressModel extends Equatable {
  final String? userId;
  final String? id;
  final String? label;
  final String? streetAddress;
  final String? apartmentNumber;
  final String? city;
  final String? state;
  final String? postalCode;
  final AddressSearchResponse? metadata;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const AddressModel({
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
        metadata: json['metadata'] != null
            ? AddressSearchResponse.fromJson(jsonDecode(json['metadata']))
            : null,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        deletedAt: json['deletedAt'] as String?,
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

  @override
  List<Object?> get props {
    return [
      userId,
      id,
      label,
      streetAddress,
      apartmentNumber,
      city,
      state,
      postalCode,
      metadata,
      createdAt,
      updatedAt,
      deletedAt,
    ];
  }
}

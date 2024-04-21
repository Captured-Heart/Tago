import 'package:tago/app.dart';

class AccountModel extends Equatable {
  final String? phoneNumber;
  final String? id;
  final String? fname;
  final String? lname;
  final String? gender;
  final String? email;
  final String? dob;
  final String? role;
  final String? emailVerifiedAt;
  final String? phoneVerifiedAt;
  final num? completedForToday;
  final double? latitude;
  final double? longitude;

  final AddressModel? address;

  const AccountModel(
      {this.phoneNumber,
      this.id,
      this.fname,
      this.lname,
      this.email,
      this.gender,
      this.role,
      this.dob,
      this.emailVerifiedAt,
      this.phoneVerifiedAt,
      this.address,
      this.completedForToday,
      this.latitude,
      this.longitude});

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        phoneNumber: json['phoneNumber'] as String?,
        id: json['id'] as String?,
        fname: json['fname'] as String?,
        lname: json['lname'] as String?,
        email: json['email'] as String?,
        dob: json['dob'] as String?,
        gender: json['gender'] as String?,
        role: json['role'] as String?,
        latitude: json['latitude'] as double?,
        longitude: json['longitude'] as double?,
        emailVerifiedAt: json['emailVerifiedAt'] as String?,
        phoneVerifiedAt: json['phoneVerifiedAt'] as String?,
        address: json['address'] == null ? null : AddressModel.fromJson(json['address']),
        completedForToday: json['completedDeliveryForToday'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'id': id,
        'fname': fname,
        'lname': lname,
        'email': email,
        'role': role,
        'dob': dob,
        'emailVerifiedAt': emailVerifiedAt,
        'phoneVerifiedAt': phoneVerifiedAt,
        'gender': gender,
        'address': address?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      phoneNumber,
      id,
      fname,
      lname,
      email,
      gender,
      dob,
      role,
      emailVerifiedAt,
      phoneVerifiedAt,
      address,
    ];
  }
}

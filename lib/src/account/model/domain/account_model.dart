import 'package:tago/app.dart';

class AccountModel extends Equatable {
  final String? phoneNumber;
  final String? id;
  final String? fname;
  final String? lname;
  final String? email;
  final String? role;
  final String? emailVerifiedAt;
  final String? phoneVerifiedAt;
  final AddressModel? address;

  const AccountModel({
    this.phoneNumber,
    this.id,
    this.fname,
    this.lname,
    this.email,
    this.role,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.address,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        phoneNumber: json['phoneNumber'] as String?,
        id: json['id'] as String?,
        fname: json['fname'] as String?,
        lname: json['lname'] as String?,
        email: json['email'] as String?,
        role: json['role'] as String?,
        emailVerifiedAt: json['emailVerifiedAt'] as String?,
        phoneVerifiedAt: json['phoneVerifiedAt'] as String?,
        address: json['address'] == null
            ? null
            : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'id': id,
        'fname': fname,
        'lname': lname,
        'email': email,
        'role': role,
        'emailVerifiedAt': emailVerifiedAt,
        'phoneVerifiedAt': phoneVerifiedAt,
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
      role,
      emailVerifiedAt,
      phoneVerifiedAt,
      address,
    ];
  }
}

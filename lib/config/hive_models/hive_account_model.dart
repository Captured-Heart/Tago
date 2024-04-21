import 'package:tago/app.dart';
part 'hive_account_model.g.dart';

@HiveType(typeId: 8)
class AccountModel extends HiveObject {
  @HiveField(0)
  final String? phoneNumber;
  @HiveField(1)
  final String? id;
  @HiveField(2)
  final String? fname;
  @HiveField(3)
  final String? lname;
  @HiveField(4)
  final String? gender;
  @HiveField(5)
  final String? email;
  @HiveField(6)
  final String? dob;
  @HiveField(7)
  final String? role;
  @HiveField(8)
  final String? emailVerifiedAt;
  @HiveField(9)
  final String? phoneVerifiedAt;
  @HiveField(10)
  final num? completedForToday;
  @HiveField(11)
  double? latitude;
  @HiveField(12)
  double? longitude;

  final AddressModel? address;

  AccountModel(
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
        address: json['address'] == null
            ? null
            : AddressModel.fromJson(json['address']),
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
}

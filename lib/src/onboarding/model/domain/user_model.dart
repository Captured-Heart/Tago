
import 'package:tago/app.dart';

class UserModel extends Equatable {
  final String? fullName;
  final int? id;
  final String? phoneNumber;
  final String? password;
  final String? otpType;

  const UserModel({
    this.fullName,
    this.id,
    this.phoneNumber,
    this.password,
    this.otpType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullName: json['fullName'] as String?,
        id: json['id'] as int?,
        phoneNumber: json['phoneNumber'] as String?,
        password: json['password'] as String?,
        otpType: json['otpType'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'fullName': fullName ?? '',
        'id': id ?? 1,
        'phoneNumber': phoneNumber ?? '',
        'password': password ?? '',
        'otpType': otpType ?? '',
      };

  @override
  List<Object?> get props {
    return [
      fullName,
      id,
      phoneNumber,
      password,
      otpType,
    ];
  }
}

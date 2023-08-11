import 'package:tago/src/onboarding/model/domain/user_model.dart';

class AuthMapper {


  
  static UserModel mapToUserModel(Map json) {
    return UserModel(
      fullName: json['fullName'],
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      otpType: json['otpType'],
    );
  }
}

// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:tago/app.dart';
import 'package:tago/core/network/networking.dart';
import 'package:tago/src/onboarding/controllers/auth_user_state.dart';

class AuthUserNotifier extends StateNotifier<AuthUserState> {
  AuthUserNotifier() : super(AuthUserState(isLoading: false, isSuccess: false));

  // final NetworkHelper networkHelper = NetworkHelper();

  Future<void> signUpUsers(Map<String, dynamic> map) async {
    state = const AuthUserState(
      isLoading: true,
      errorMessage: '',
      isSuccess: false,
    );

    try {
      //post request executed
      final Response response = await NetworkHelper.postRequest(
        map: map,
        api: signUpUrl,
      );

      // decoding the response
      String data = response.body;
      var decodedData = jsonDecode(data);
      log('Post request $decodedData'); //

      //the response and error handling
      if (response.statusCode == 200 || response.statusCode == 422) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        log('Post request successful $decodedData'); //
        state = AuthUserState(
          isLoading: false,
          isSuccess: true,
          errorMessage: decodedData['message'],
        );
        return decodedData;
      } else {
        state = AuthUserState(
          isLoading: false,
          isSuccess: false,
          errorMessage: decodedData['message'],
        );
        // log(decodedData['message']);
      }
    } on HttpException catch (error) {
      log(error.message);
      state = AuthUserState(
        isLoading: false,
        errorMessage: error.message,
        isSuccess: false,
      );
    } catch (e) {
      log(e.toString());

      state = AuthUserState(
        isLoading: false,
        errorMessage: e.toString(),
        isSuccess: false,
      );
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:tago/app.dart';
import 'package:tago/core/network/networking.dart';

class AuthUserNotifier extends StateNotifier<AuthUserState> {
  AuthUserNotifier()
      : super(const AuthUserState(isLoading: false, isSuccess: false));

  // Future<void> signUpUsers(Map<String, dynamic> map) {
  //   return signUpMethod(map, state);
  // }

  // Future<void> signInUsers(Map<String, dynamic> map) {
  //   return signInMethod(map, state);
  // }

  // Future<void> forgotpassword(Map<String, dynamic> map) {
  //   return forgotPasswordMethod(
  //     map: map,
  //     state: state,
  //   );
  // }

/*------------------------------------------------------------------
SIGN UP USERS METHOD
 -------------------------------------------------------------------*/
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
      log('http exception: ${error.message}');
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

/*------------------------------------------------------------------
SIGN IN USERS METHOD
 -------------------------------------------------------------------*/
  Future<void> signInUsers(Map<String, dynamic> map) async {
    state = const AuthUserState(
      isLoading: true,
      errorMessage: '',
      isSuccess: false,
    );

    try {
      //post request executed
      final Response response = await NetworkHelper.postRequest(
        map: map,
        api: signInUrl,
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

/*------------------------------------------------------------------
FORGOT PASSWORD METHOD
 -------------------------------------------------------------------*/
  Future<void> forgotPassword(
      Map<String, dynamic> map, VoidCallback onSuccess) async {
    state = const AuthUserState(
      isLoading: true,
      errorMessage: '',
      isSuccess: false,
    );

    try {
      //post request executed
      final Response response = await NetworkHelper.postRequest(
        map: map,
        api: forgotPasswordUrl,
      );

      // decoding the response
      String data = response.body;
      var decodedData = jsonDecode(data);
      log('Post request $decodedData'); //

      //the response and error handling

      if (decodedData['success'] == true) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        log('Post request successful $decodedData'); //
        onSuccess();

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

  /*------------------------------------------------------------------
RESET PASSWORD METHOD
 -------------------------------------------------------------------*/
  Future<void> resetPassword(Map<String, dynamic> map) async {
    state = const AuthUserState(
      isLoading: true,
      errorMessage: '',
      isSuccess: false,
    );

    try {
      //post request executed
      final Response response = await NetworkHelper.postRequest(
        map: map,
        api: resetPasswordUrl,
      );

      // decoding the response
      String data = response.body;
      var decodedData = jsonDecode(data);
      log('Response from a decodedData:  $decodedData'); //

      //the response and error handling

      if (decodedData['success'] == true) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        log('Post request successful: $decodedData'); //
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
      log('httpexception error: ${error.message}');
      state = AuthUserState(
        isLoading: false,
        errorMessage: error.message,
        isSuccess: false,
      );
    } catch (e) {
      log('the catch error: ${e.toString()}');

      state = AuthUserState(
        isLoading: false,
        errorMessage: e.toString(),
        isSuccess: false,
      );
    }
  }

  /*------------------------------------------------------------------
Confirm RESET PASSWORD METHOD
 -------------------------------------------------------------------*/
  Future<void> confirmResetPassword(
      Map<String, dynamic> map, Function onSuccess) async {
    state = const AuthUserState(
      isLoading: true,
      errorMessage: '',
      isSuccess: false,
    );

    try {
      //post request executed
      final Response response = await NetworkHelper.postRequest(
        map: map,
        api: confirmResetPasswordUrl,
      );

      // decoding the response
      String data = response.body;
      var decodedData = jsonDecode(data);
      log('Response from a decodedData:  $decodedData'); //

      //the response and error handling

      if (decodedData['success'] == true) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        log('Post request successful: $decodedData'); //
        state = AuthUserState(
          isLoading: false,
          isSuccess: true,
          errorMessage: decodedData['message'],
        );
        onSuccess();
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
      log('httpexception error: ${error.message}');
      state = AuthUserState(
        isLoading: false,
        errorMessage: error.message,
        isSuccess: false,
      );
    } catch (e) {
      log('the catch error: ${e.toString()}');

      state = AuthUserState(
        isLoading: false,
        errorMessage: e.toString(),
        isSuccess: false,
      );
    }
  }
}

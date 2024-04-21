/*------------------------------------------------------------------
SIGN UP USERS METHOD
 -------------------------------------------------------------------*/
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:tago/app.dart';
import 'package:tago/core/network/networking.dart';

Future<void> signUpMethod(Map<String, dynamic> map, AuthUserState state) async {
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
Future<void> signInMethod(Map<String, dynamic> map, AuthUserState state) async {
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
Future<void> forgotPasswordMethod({
  required Map<String, dynamic> map,
  required AuthUserState state,
  // required VoidCallback onSuccess,
}) async {
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

// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:tago/app.dart';
import 'package:tago/config/constants/hive_keys.dart';
import 'package:tago/core/network/networking.dart';
import 'package:tago/src/onboarding/model/auth_exception.dart';

import '../../../config/utils/dialogs.dart';

final authAsyncNotifierProvider =
    StateNotifierProvider<AuthAsyncNotifier, AsyncValue>((ref) {
  return AuthAsyncNotifier();
});

class AuthAsyncNotifier extends StateNotifier<AsyncValue> {
  AuthAsyncNotifier() : super(const AsyncValue.data(null));

/*------------------------------------------------------------------
SIGN UP USERS METHOD
 -------------------------------------------------------------------*/
  Future<void> signUpAsyncMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
    required String phoneno,
  }) async {
    state = const AsyncValue.loading();
    //post request executed
    final Response response = await NetworkHelper.postRequest(
      map: map,
      api: signUpUrl,
    ).timeout(const Duration(seconds: 25), onTimeout: () {
      state = const AsyncValue.data(null);

      showScaffoldSnackBarMessage('Connection timeout, try again');
    });

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);

    //the response and error handling
    if (decodedData['success'] == true) {
      log('came in here');
      await HiveHelper()
          .saveData(HiveKeys.token.keys, decodedData['data']['access_token']);
      await HiveHelper()
          .saveData(HiveKeys.role.keys, decodedData['data']['role']);

      state = AsyncValue.data(decodedData['message']);

      push(
          context,
          ConfirmPhoneNumberScreen(
            phoneno: phoneno,
          ));

      return decodedData;
    } else {
      state = AsyncValue.error(
          decodedData['message'], StackTrace.fromString('stackTraceString'));
      showAuthBottomSheet(
        context: context,
      );
    }
  }

  /*------------------------------------------------------------------
SIGN IN USERS METHOD
 -------------------------------------------------------------------*/
  Future<void> signInAsyncMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    //post request executed
    final Response response = await NetworkHelper.postRequest(
      map: map,
      api: signInUrl,
    ).timeout(const Duration(seconds: 25), onTimeout: () {
      state = const AsyncValue.data(null);
      showScaffoldSnackBarMessage('Connection timeout, try again');
    });

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);

    //the response and error handling
    if (decodedData['success'] == true) {
      log('came in here');
      await HiveHelper()
          .saveData(HiveKeys.token.keys, decodedData['data']['access_token']);
      await HiveHelper()
          .saveData(HiveKeys.role.keys, decodedData['data']['role']);

      state = AsyncValue.data(decodedData['message']);

//NAVIGATING TO THE MAIN SCREEN
      pushReplacement(
        context,
        const MainScreen(),
      );

      return decodedData;
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      showAuthBottomSheet(
        context: context,
      );
    }
  }

/*------------------------------------------------------------------
FORGOT PASSWORD METHOD
 -------------------------------------------------------------------*/
  Future<void> forgotPasswordAsyncMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    //post request executed
    final Response response = await NetworkHelper.postRequest(
      map: map,
      api: forgotPasswordUrl,
    ).timeout(const Duration(seconds: 25), onTimeout: () {
      state = const AsyncValue.data(null);
      showScaffoldSnackBarMessage('Connection timeout, try again');
    });

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);

    //the response and error handling
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);

      warningDialogs(state.value ?? '');
      push(
        context,
        ConfirmResetCodeScreen(
          phoneNo: map.values.map((e) => e).toString(),
        ),
      );

      return decodedData;
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      showAuthBottomSheet(
        context: context,
      );
    }
  }

  /*------------------------------------------------------------------
Confirm RESET PASSWORD METHOD
 -------------------------------------------------------------------*/
  Future<void> confirmResetPasswordAsyncMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    //post request executed
    final Response response = await NetworkHelper.postRequest(
      map: map,
      api: verifyResetCode,
    ).timeout(const Duration(seconds: 25), onTimeout: () {
      state = const AsyncValue.data(null);
      showScaffoldSnackBarMessage('Connection timeout, try again');
    });

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);

    //the response and error handling
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);

      warningDialogs(state.value ?? '');

      //navigation
      push(
        context,
        const ResetPasswordScreen(),
      );

      return decodedData;
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      showAuthBottomSheet(
        context: context,
      );
    }
  }
}

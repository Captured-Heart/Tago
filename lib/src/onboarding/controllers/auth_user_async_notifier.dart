// ignore_for_file: use_build_context_synchronously

import 'package:tago/app.dart';

final authAsyncNotifierProvider = StateNotifierProvider<AuthAsyncNotifier, AsyncValue>((ref) {
  return AuthAsyncNotifier();
});

class AuthAsyncNotifier extends StateNotifier<AsyncValue> {
  AuthAsyncNotifier() : super(const AsyncValue.data(null));
  TextEditingControllerClass controller = TextEditingControllerClass();
/*------------------------------------------------------------------
                  SIGN UP USERS METHOD
 -------------------------------------------------------------------*/
  Future<void> signUpAsyncMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
    required String phoneno,
  }) async {
    state = const AsyncValue.loading();

    try {
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
        await HiveHelper().saveData(HiveKeys.token.keys, decodedData['data']['access_token']);
        await HiveHelper().saveData(HiveKeys.role.keys, decodedData['data']['role']);
        log('decodedData: $decodedData');

        state = AsyncValue.data(decodedData['message']);
        controller.disposeControllers();
        push(
            context,
            ConfirmPhoneNumberScreen(
              phoneno: phoneno,
            ));

        return decodedData;
      } else {
        state = AsyncValue.error(decodedData['message'], StackTrace.empty);
        showAuthBottomSheet(
          context: context,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /*------------------------------------------------------------------
                      SIGN IN USERS METHOD
 -------------------------------------------------------------------*/
  Future<void> signInAsyncMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
    required Function onNavigation,
  }) async {
    state = const AsyncValue.loading();

    try {
      final Response response = await NetworkHelper.postRequest(
        map: map,
        api: signInUrl,
      )
          .onError(
        (error, stackTrace) => state = AsyncValue.error(error!, stackTrace),
      )
          .timeout(const Duration(seconds: 25), onTimeout: () {
        state = const AsyncValue.data(null);
        state = const AsyncValue.error('error, try again', StackTrace.empty);
        showScaffoldSnackBarMessage('Connection timeout, try again', isError: true);
      });

      // decoding the response
      String data = response.body;
      var decodedData = jsonDecode(data);

      //the response and error handling
      if (decodedData['success'] == true) {
        log('came in here');
        await HiveHelper().saveData(HiveKeys.token.keys, decodedData['data']['access_token']);
        await HiveHelper().saveData(HiveKeys.role.keys, decodedData['data']['role']);

        state = AsyncValue.data(decodedData['message']);
        log('decodedData: $decodedData');

//NAVIGATING TO THE MAIN SCREEN
        onNavigation();

        return decodedData;
      }
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.empty);
    }
  }

/*------------------------------------------------------------------
                    FORGOT PASSWORD METHOD
 -------------------------------------------------------------------*/
  Future<void> forgotPasswordAsyncMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
    required String phoneNo,
    required Function onNavigation,
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
      log('decodedData: $decodedData');

      // warningDialogs(decodedData['message']);
      showScaffoldSnackBarMessage(decodedData['message']);
      onNavigation();

      return decodedData;
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      showAuthBottomSheet(
        context: context,
      );
    }
  }

  /*------------------------------------------------------------------
                  VERIFY RESET CODE METHOD
 -------------------------------------------------------------------*/
  Future<void> verifyResetcodeMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    //post request executed
    final Response response = await NetworkHelper.postRequest(
      map: map,
      api: verifyResetCodeUrl,
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
      await HiveHelper().saveData(HiveKeys.token.keys, decodedData['data']['access_token']);
      // warningDialogs(state.value ?? '');
      log('decodedData: $decodedData');

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

  /*------------------------------------------------------------------
                    SEND OTP METHOD
 -------------------------------------------------------------------*/
  Future<void> resendOtpMethod(context) async {
    state = const AsyncValue.loading();

    Response response = await NetworkHelper.postRequestWithToken(
      map: {'otpType': 'verify-phone-number'},
      api: sendOtpUrl,
    ).timeout(const Duration(seconds: 25), onTimeout: () {
      state = const AsyncValue.data(null);
      showScaffoldSnackBarMessage('Connection timeout, try again');
    });

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);

    if (decodedData['success'] == true) {
      showScaffoldSnackBarMessage(decodedData['message']);

      state = AsyncValue.data(decodedData['message']);
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      showAuthBottomSheet(
        context: context,
      );
    }
  }

  /*------------------------------------------------------------------
                  VERIFY PHONE NUMBER METHOD
 -------------------------------------------------------------------*/
  Future<void> verifyPhoneNumberMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    //post request executed
    final Response response = await NetworkHelper.postRequestWithToken(
      map: map,
      api: verifyPhoneNumberUrl,
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
      log('decodedData: $decodedData');

      showScaffoldSnackBarMessage(decodedData['message']);

      //navigation
      push(
        context,
        const AddAddressScreen(),
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
                      RESET PASSWORD METHOD
 -------------------------------------------------------------------*/
  Future<void> resetPasswordMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    //post request executed
    final Response response = await NetworkHelper.postRequest(
      map: map,
      api: resetPasswordUrl,
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
      log('decodedData: $decodedData');
      // warningDialogs(context, state.value ?? '');

      push(
        context,
        const ResetSuccessfulScreen(),
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

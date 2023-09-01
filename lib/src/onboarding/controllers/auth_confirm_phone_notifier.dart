import 'package:tago/app.dart';
import 'package:tago/core/network/networking.dart';

final authConfirmPhoneNoProvider =
    StateNotifierProvider<AuthConfirmPhoneNoNotifier, AsyncValue>((ref) {
  return AuthConfirmPhoneNoNotifier();
});

class AuthConfirmPhoneNoNotifier extends StateNotifier<AsyncValue> {
  AuthConfirmPhoneNoNotifier() : super(const AsyncValue.data(null));
  Future<void> resendOtpMethod(context) async {
    state = const AsyncValue.loading();

    Response response = await NetworkHelper.postRequestWithToken(
      map: {'otpType': 'verify-phone-number'},
      api: sendOtp,
    );

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);

    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);
      // pushNamed(context, AddAddressScreen.routeName);
    } else {
      state = AsyncValue.data(decodedData['message']);
    }
  }

  Future<void> verifyResetCodeMethod({
    required Map<String, dynamic> map,
  }) async {
    state = const AsyncValue.loading();

    Response response = await NetworkHelper.postRequest(
      map: map,
      api: verifyResetCode,
    );

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);

    log('decodedData for verify reset code: $decodedData');
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);
    } else {
      state = AsyncValue.data(decodedData['message']);
    }
  }
}

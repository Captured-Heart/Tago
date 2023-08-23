import 'dart:io';

import 'package:tago/app.dart';
import 'package:tago/config/hive_local_storage.dart';
import 'package:tago/core/network/networking.dart';
import 'package:tago/src/onboarding/model/auth_exception.dart';

final authAsyncNotifierProvider =
    StateNotifierProvider<AuthAsyncNotifier, AsyncValue>((ref) {
  return AuthAsyncNotifier();
});

class AuthAsyncNotifier extends StateNotifier<AsyncValue> {
  AuthAsyncNotifier() : super(const AsyncValue.data(null));

  Future<void> signUpAsyncMethod(Map<String, dynamic> map) async {
    try {
      state = const AsyncValue.loading();
      //post request executed
      final Response response = await NetworkHelper.postRequest(
        map: map,
        api: signUpUrl,
      );

      // decoding the response
      String data = response.body;
      var decodedData = jsonDecode(data);
      log('Post request token ${decodedData['data']['access_token']}');
      log('Post request $decodedData'); //4
      //the response and error handling
      if (decodedData['success'] == true) {
        log('came in here');
        await HiveHelper()
            .saveData('token', decodedData['data']['access_token']);

        state = AsyncValue.data(decodedData['message']);
        return decodedData;
      } else {
        state = AsyncValue.error(decodedData['message'], StackTrace.empty);
        // log(decodedData['message']);
      }
    } on HttpException catch (error) {
      log('http exception: ${error.message}');
      state = AsyncValue.error(error.message, StackTrace.current);

      throw AuthAsyncException(error.message);
    } on AuthAsyncException catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);

      throw AuthAsyncException(e.error);
    }
  }
}

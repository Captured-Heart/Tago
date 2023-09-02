// ignore_for_file: use_build_context_synchronously

import 'package:tago/app.dart';

/*------------------------------------------------------------------
                  GET ACCOUNT ADDRESS PROVIDER
 -------------------------------------------------------------------*/
final getAccountAddressProvider =
    FutureProvider<List<AddressModel>>((ref) async {
  return getAddressMethod();
});

/*------------------------------------------------------------------
                 ACCOUNT ADDRESS STATE NOTIFIER PROVIDER
 -------------------------------------------------------------------*/
final accountAddressProvider =
    StateNotifierProvider<AccountAddressNotifier, AsyncValue>((ref) {
  return AccountAddressNotifier();
});

/*------------------------------------------------------------------
                  ACCOUNT ADDRESS STATE NOTIFIER 
 -------------------------------------------------------------------*/
class AccountAddressNotifier extends StateNotifier<AsyncValue> {
  AccountAddressNotifier() : super(const AsyncValue.data(null));

  Future<List<AddressModel>> addAddressMethod({
    required Map<String, dynamic> map,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = const AsyncValue.loading();
    //post request executed
    final Response response = await NetworkHelper.postRequestWithToken(
      api: addAddressUrl,
      map: map,
    );

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);
    //the response and error handling
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);
      pop(context);
      Future.delayed(const Duration(milliseconds: 200), () {
        ref.invalidate(getAccountAddressProvider);

        showScaffoldSnackBarMessage(decodedData['message']);
      });

      return decodedData['message'];
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      return decodedData['message'];
    }
  }
}

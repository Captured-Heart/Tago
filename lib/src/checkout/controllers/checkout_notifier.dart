import 'package:tago/app.dart';

class CheckOutNotifier extends StateNotifier<AsyncValue> {
  CheckOutNotifier() : super(const AsyncValue.data(null));

  // /*------------------------------------------------------------------
//              CREATE AN ORDER METHOD
//  -------------------------------------------------------------------*/

  Future<dynamic> createAnOrderMethod({
    required Map<String, dynamic> map,
  }) async {
    state = const AsyncValue.loading();
    // post request executed
    final Response response = await NetworkHelper.postRequestWithToken(
      api: createAnOrderUrl,
      map: map,
    )
        .timeout(const Duration(seconds: 10), onTimeout: () {
          showScaffoldSnackBarMessage(NetworkErrorEnums.operationTimeOut.message);
          state = const AsyncValue.data(null);
        })
        .onError((error, stackTrace) => state = const AsyncValue.data(null))
        .catchError((op) {
          return state = const AsyncValue.data(null);
        });

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);
    //the response and error handling
    if (decodedData['success'] == true || response.statusCode == 200) {
      state = AsyncValue.data(decodedData['data']);
      var createdOrder = CheckoutModel.fromJson(decodedData['data']);
      showScaffoldSnackBarMessage(decodedData['message']);

      return createdOrder;
    } else {
      showScaffoldSnackBarMessage(decodedData['message'], isError: true);
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      return decodedData['message'];
    }
  }
}

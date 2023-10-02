import 'package:tago/app.dart';

class CartMethodNotifier extends StateNotifier<AsyncValue> {
  CartMethodNotifier() : super(const AsyncValue.data(null));

/*------------------------------------------------------------------
             ADD TO CART METHOD
 -------------------------------------------------------------------*/
  Future<String> addToCartMethod({
    required Map<String, dynamic> map,
  }) async {
    state = const AsyncValue.loading();
    // try {
    //post request executed
    final Response response = await NetworkHelper.postRequestWithToken(
      //is the same url as get carts
      api: getCartsUrl,
      map: map,
    );

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);
    //the response and error handling
    if (decodedData['success'] == true || response.statusCode == 200) {
      state = AsyncValue.data(decodedData['message']);
      // showScaffoldSnackBarMessage(decodedData['message'], duration: 2);

      log('add request for cart model for add:  ${decodedData['message']}'); //

      return decodedData['message'];
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      // showScaffoldSnackBarMessage(decodedData['message'],
      //     duration: 3, isError: true);
      return decodedData['message'];
    }
  }

  /*------------------------------------------------------------------
             DELETE FROM CART METHOD
 -------------------------------------------------------------------*/
  Future<String> deleteFromCartMethod({
    required Map<String, dynamic> map,
  }) async {
    state = const AsyncValue.loading();
    // try {
    //post request executed
    final Response response = await NetworkHelper.deleteRequestWithToken(
      //is the same url as get carts
      api: getCartsUrl,
      map: map,
    );

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);
    //the response and error handling
    if (decodedData['success'] == true || response.statusCode == 200) {
      state = AsyncValue.data(decodedData['message']);
      // showScaffoldSnackBarMessage(decodedData['message'], duration: 2);

      log('delete request for cart model delete:  ${decodedData['message']}'); //

      return decodedData['message'];
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      // showScaffoldSnackBarMessage(decodedData['message'],
      //     duration: 2, isError: true);
      return decodedData['message'];
    }
  }
}

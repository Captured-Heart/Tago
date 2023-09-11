import 'package:tago/app.dart';

final postToWishListNotifierProvider =
    StateNotifierProvider<PostToWishListNotifier, AsyncValue>((ref) {
  return PostToWishListNotifier();
});

class PostToWishListNotifier extends StateNotifier<AsyncValue> {
  PostToWishListNotifier() : super(const AsyncValue.data(null));

/*------------------------------------------------------------------
              POST WISHLIST METHOD
 -------------------------------------------------------------------*/
  Future<String> postToWishListMethod(
      {required Map<String, dynamic> map}) async {
    // try {
    //post request executed
    state = const AsyncValue.loading();
    final Response response = await NetworkHelper.postRequestWithToken(
      api: getWishListUrl,
      map: map,
    );

    // decoding the response
    log('responseBody: ${response.body}');
    String data = response.body;
    var decodedData = jsonDecode(data);

    //the response and error handling
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);
      log('get request for WishList:  ${decodedData['data']}'); //
      showScaffoldSnackBarMessage(decodedData['message']);
      return decodedData['message'];
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      showScaffoldSnackBarMessage(decodedData['message'], isError: true);
      return decodedData['message'];
    }
  }
}

import 'package:tago/app.dart';

/*------------------------------------------------------------------
              FETCH WISHLIST METHOD
 -------------------------------------------------------------------*/

Future<List<ProductsModel>> fetchWishListMethod() async {
  // try {
  //post request executed
  final Response response =
      await NetworkHelper.getRequest(api: getWishListUrl, headers: {
    'Authorization': HiveHelper().getData(HiveKeys.token.name),
  });

  // decoding the response
  log('responseBody: ${response.body}');
  String data = response.body;
  var decodedData = jsonDecode(data);

  //the response and error handling
  if (decodedData['success'] == true) {
    // log('get request for Categories:  $decodedData'); //

    // final wishList = (decodedData['data'] as List)
    //     .map((e) => ProductsModel.fromJson(e))
    //     .toList();
    log('get request for WishList:  ${decodedData['data']}'); //

    return decodedData[''];
  } else {
    return decodedData['message'];
  }
}

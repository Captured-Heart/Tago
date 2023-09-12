import 'package:tago/app.dart';

/*------------------------------------------------------------------
              FETCH WISHLIST METHOD
 -------------------------------------------------------------------*/

Future<List<ProductsModel>> fetchWishListMethod() async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequest(api: getWishListUrl, headers: {
    'Authorization': HiveHelper().getData(HiveKeys.token.name),
  });

  // decoding the response
  // log('responseBody: ${response.body}');
  String data = response.body;
  var decodedData = jsonDecode(data);

  //the response and error handling
  if (decodedData['success'] == true) {
    // log('get request for Categories:  $decodedData'); //

    // final wishList = ProductsModel.fromJson(decodedData['data'][0]['product']);
    final wishList = (decodedData['data'] as List)
        .map((e) => e['product'])
        // .where((element) => element == ['product'])
        .map((e) => ProductsModel.fromJson(e))
        .toList();

    showScaffoldSnackBarMessage(decodedData['message']);

    return wishList;
  } else {
    showScaffoldSnackBarMessage(decodedData['message'], isError: true);
    return decodedData['message'];
  }
}

/*------------------------------------------------------------------
              POST WISHLIST METHOD
 -------------------------------------------------------------------*/

// Future<String> postToWishListMethod({required Map<String, dynamic> map}) async {
//   // try {
//   //post request executed
//   final Response response = await NetworkHelper.postRequestWithToken(
//     api: getWishListUrl,
//     map: map,
//   );

//   // decoding the response
//   log('responseBody: ${response.body}');
//   String data = response.body;
//   var decodedData = jsonDecode(data);

//   //the response and error handling
//   if (decodedData['success'] == true) {
//     log('get request for WishList:  ${decodedData['data']}'); //
//     showScaffoldSnackBarMessage(decodedData['message']);
//     return decodedData['message'];
//   } else {
//     return decodedData['message'];
//   }
// }

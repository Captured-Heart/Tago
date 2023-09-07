import 'package:tago/app.dart';

/*------------------------------------------------------------------
             GET LIST OF CART METHOD
 -------------------------------------------------------------------*/
Future<List<CartModel>> getCartMethod() async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: getCartsUrl,
  );

  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);
  //the response and error handling
  if (decodedData['success'] == true) {
    showScaffoldSnackBarMessage(decodedData['message'], duration: 3);
    final addressList = (decodedData['data'] as List)
        .map((e) => CartModel.fromJson(e))
        .toList();
    log('get request for cart model:  ${decodedData['data']}'); //

    return addressList;
  } else {
    return decodedData['message'];
  }
}

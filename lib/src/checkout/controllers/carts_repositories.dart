import 'package:tago/app.dart';

/*------------------------------------------------------------------
             GET LIST OF CART METHOD
 -------------------------------------------------------------------*/
Future<List<CartModel>> getCartMethod({
  bool showSnackBar = true,
}) async {
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
    showSnackBar == true
        ? showScaffoldSnackBarMessage(decodedData['message'], duration: 3)
        : null;
    final cartList = (decodedData['data'] as List)
        .map((e) => CartModel.fromJson(e))
        .toList();
    // log('get request for cart model:  ${decodedData['data']}'); //

    return cartList;
  } else {
    return [];
  }
}

/*------------------------------------------------------------------
             GET VOUCHER METHOD
 -------------------------------------------------------------------*/
Stream<VoucherModel> getVoucherMethod({
  required String code,
}) async* {
  // try {
  //post request executed
  // /account/user/checkout/voucher?code=MT7663G
  var url = '$voucherUrl?code=$code';
  final Response response = await NetworkHelper.getRequestWithToken(
    api: url,
  );
  // log(url);
  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);

  log(response.statusCode.toString());
  //the response and error handling
  if (response.statusCode == 200 || decodedData['success'] == true) {
    // log('get request for Categories:  $decodedData'); //

    final vouchers = VoucherModel.fromJson(decodedData['data']);
    // log('get request for Search by code:  $vouchers'); //

    yield vouchers;
  } else {
    log('not successful');
    yield const VoucherModel(code: null, currency: null, amount: null);
  }
}

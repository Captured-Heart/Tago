/*------------------------------------------------------------------
              FETCH ADDRESS METHOD
 -------------------------------------------------------------------*/

import 'package:tago/app.dart';

import '../model/domain/account_model.dart';

Future<List<AddressModel>> getAddressMethod() async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: getAddressUrl,
  );

  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);
  //the response and error handling
  if (decodedData['success'] == true) {
    final addressList = (decodedData['data'] as List).map((e) => AddressModel.fromJson(e)).toList();
    log('get request for address:  ${decodedData['data']}'); //

    return addressList;
  } else {
    return decodedData['message'];
  }
}

/*------------------------------------------------------------------
             GET ACCOUNT INFO
 -------------------------------------------------------------------*/
Future<AccountModel> getAccountInfoMethod() async {
  //post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: getAccountInfoUrl,
  );

  // decoding the response
  String data = response.body;
  var decodedData = jsonDecode(data);
  // log(decodedData['data'].toString());
  //the response and error handling
  if (decodedData['success'] == true) {
    // final addressInfo = (decodedData['data'] as List).map((e) => AccountModel.fromJson(e)).toList();
    final addressInfo = AccountModel.fromJson(decodedData['data']);

    return addressInfo;
  } else {
    return decodedData['message'];
  }
}

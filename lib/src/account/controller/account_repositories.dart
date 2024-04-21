/*------------------------------------------------------------------
              FETCH ADDRESS METHOD
 -------------------------------------------------------------------*/

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tago/app.dart';

Future<List<AddressModel>> getAddressMethod(AutoDisposeFutureProviderRef ref) async {
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
    // log('get request for address:  ${decodedData['data']}'); //

    // ref.read(addressIdProvider.notifier).update((state) {
    //   if ((decodedData['data'] as List).isNotEmpty) {
    //     // return '${decodedData['data'][0]['id']}';

    //     return '${decodedData['data'][HiveHelper().getAddressIndex(HiveKeys.addressId.keys)]['id']}';
    //   }
    //   return '';
    // });

    return addressList;
  } else {
    return [AddressModel()];
  }
}

/*------------------------------------------------------------------
             GET ACCOUNT INFO
 -------------------------------------------------------------------*/
Future<AccountModel> getAccountInfoMethod() async {
  //post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: getAccountInfoUrl,
  ).timeout(
      const Duration(
        seconds: 10,
      ), onTimeout: () {
    throw Exception('Time out');
  }); // WidgetRef? ref;

  log("load account");
  // decoding the response
  String data = response.body;
  var decodedData = jsonDecode(data);
  // log(decodedData['data'].toString());
  //the response and error handling
  if (decodedData['success'] == true) {
    // final addressInfo = (decodedData['data'] as List).map((e) => AccountModel.fromJson(e)).toList();
    final addressInfo = AccountModel.fromJson(decodedData['data']);
    // log('addressId from method: ${decodedData['data']['id']}');
    return addressInfo;
  } else {
    return AccountModel();
    // throw UnimplementedError(decodedData['message']);
    // return decodedData['message'];
  }
}

/*------------------------------------------------------------------
             UPDATE ACCOUNT FBM TOKEN
 -------------------------------------------------------------------*/
Future<void> updateAccountFbmTokenMethod() async {
  String? fbToken = await FirebaseMessaging.instance.getToken();
  log(fbToken!);
  var response =
      await NetworkHelper.postRequestWithToken(api: updateFbTokenUrl, map: {"fbToken": fbToken});
  log(response.toString());
}

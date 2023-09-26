// ignore_for_file: use_build_context_synchronously

import 'package:tago/app.dart';

class RiderAcceptDeclineNotifier extends StateNotifier<AsyncValue> {
  RiderAcceptDeclineNotifier() : super(const AsyncValue.data(null));
  // /*------------------------------------------------------------------
//            RIDER ACCEPT METHOD
//  -------------------------------------------------------------------*/
  Future<void> riderAcceptReqestMethod({
    bool showSnackBar = true,
    required VoidCallback onNavigation,
    required Map<String, dynamic> map,
  }) async {
    state = const AsyncValue.loading();
    // try {
    //post request executed
    final Response response = await NetworkHelper.postRequestWithToken(
      api: riderAcceptUrl,
      map: map,
    );

    // decoding the response

    String data = response.body;
    var decodedData = jsonDecode(data);
    //the response and error handling
    log(decodedData['data'].toString());
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);
      showScaffoldSnackBarMessage(decodedData['message']);
      onNavigation();
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      showScaffoldSnackBarMessage(decodedData['message'], isError: true);
    }
  }

  // /*------------------------------------------------------------------
//             RIDER DELETE METHOD
//  -------------------------------------------------------------------*/
  Future<void> riderDeleteReqestMethod({
    bool showSnackBar = true,
    required VoidCallback onNavigation,
    required Map<String, dynamic> map,
  }) async {
    state = const AsyncValue.loading();
    // try {
    //post request executed
    final Response response = await NetworkHelper.postRequestWithToken(
      api: riderDeleteUrl,
      map: map,
    );

    // decoding the response

    String data = response.body;
    var decodedData = jsonDecode(data);
    //the response and error handling
    log(decodedData['data'].toString());
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);
      showScaffoldSnackBarMessage(decodedData['message']);
      onNavigation();
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      showScaffoldSnackBarMessage(decodedData['message'], isError: true);
    }
  }

  // /*------------------------------------------------------------------
//             RIDER PICKED UP METHOD
//  -------------------------------------------------------------------*/
  Future<void> riderPickUpMethod({
    bool showSnackBar = true,
    required VoidCallback onNavigation,
    required Map<String, dynamic> map,
  }) async {
    state = const AsyncValue.loading();
    // try {
    //post request executed
    final Response response = await NetworkHelper.postRequestWithToken(
      api: riderPickUpUrl,
      map: map,
    );

    // decoding the response

    String data = response.body;
    var decodedData = jsonDecode(data);
    //the response and error handling
    log(decodedData['data'].toString());
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);
      showScaffoldSnackBarMessage(decodedData['message']);
      onNavigation();
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      showScaffoldSnackBarMessage(decodedData['message'], isError: true);
    }
  }

  // /*------------------------------------------------------------------
//             RIDER DELIVERED UP METHOD
//  -------------------------------------------------------------------*/
  Future<void> riderDeliveredMethod({
    bool showSnackBar = true,
    required VoidCallback onNavigation,
    required Map<String, dynamic> map,
  }) async {
    state = const AsyncValue.loading();
    // try {
    //post request executed
    final Response response = await NetworkHelper.postRequestWithToken(
      api: riderDeliveredUrl,
      map: map,
    );

    // decoding the response

    String data = response.body;
    var decodedData = jsonDecode(data);
    //the response and error handling
    log(decodedData['data'].toString());
    if (decodedData['success'] == true) {
      state = AsyncValue.data(decodedData['message']);
      showScaffoldSnackBarMessage(decodedData['message']);
      onNavigation();
    } else {
      state = AsyncValue.error(decodedData['message'], StackTrace.empty);
      showScaffoldSnackBarMessage(decodedData['message'], isError: true);
    }
  }
}

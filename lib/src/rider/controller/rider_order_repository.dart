import 'package:tago/app.dart';
/*------------------------------------------------------------------
             GET RIDERS LIST OF ORDERS METHOD
 -------------------------------------------------------------------*/

Future<List<OrderListModel>> getRiderListOfOrderMethod({
  bool showSnackBar = true,
}) async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: riderListOfOrdersUrl,
  );

  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);
  //the response and error handling
  log(decodedData['data'].toString());
  if (decodedData['success'] == true) {
    log('entered here');
    // showSnackBar ? showScaffoldSnackBarMessage(decodedData['message'], duration: 3) : null;
    final orderList = (decodedData['data'] as List)
        .map((e) => OrderListModel.fromJson(e))
        .toList();
    // log('get request for cart model:  ${decodedData['data']}'); //

    return orderList;
  } else {
    return [];
  }
}

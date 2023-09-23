import 'package:tago/app.dart';
/*------------------------------------------------------------------
             GET LIST OF ORDERS METHOD
 -------------------------------------------------------------------*/

Future<List<OrderListModel>> getListOfOrderMethod({
  bool showSnackBar = true,
}) async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: getListOfOrdersUrl,
  );

  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);
  //the response and error handling
  if (decodedData['success'] == true) {
    showSnackBar
        ? showScaffoldSnackBarMessage(decodedData['message'], duration: 3)
        : null;
    final orderList = (decodedData['data'] as List)
        .map((e) => OrderListModel.fromJson(e))
        .toList();
    // log('get request for cart model:  ${decodedData['data']}'); //

    return orderList;
  } else {
    return [];
  }
}

/*------------------------------------------------------------------
             GET ORDER STATUS METHOD
 -------------------------------------------------------------------*/
Future<OrderListModel> getOrderStatusMethod({
  required String orderId,
}) async {
  var url = '$getOrderStatusUrl?orderId=$orderId';
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: url,
  );

  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);
  //the response and error handling
  if (decodedData['success'] == true) {
    final orderStatus = OrderListModel.fromJson(decodedData['data']);
    // log('get request for cart model:  ${decodedData['data']}'); //

    return orderStatus;
  } else {
    throw UnimplementedError();
    // return OrderListModel();
  }
}

import 'dart:convert';

import 'package:tago/app.dart';
/*------------------------------------------------------------------
             GET RIDERS LIST OF ORDERS METHOD
 -------------------------------------------------------------------*/

Future<List<OrderListModel>> getRiderListOfOrderMethod({
  bool showSnackBar = true,
}) async {
  final Response response = await NetworkHelper.getRequestWithToken(
    api: riderListOfOrdersUrl,
  );
  String data = response.body;
  var decodedData = jsonDecode(data);

  if (decodedData['success'] == true) {
    final orderList = (decodedData['data'] as List)
        .map((e) => OrderListModel.fromJson(e))
        .toList();
    orderList.sort((a, b) => b.status!.compareTo(a.status!));
    return orderList;
  } else {
    return [];
  }
}

import 'package:tago/app.dart';

/*------------------------------------------------------------------
             GET DELIVERY REQUESTS METHOD
 -------------------------------------------------------------------*/
Future<List<OrderModel>> getDeliveryRequestsMethod() async {
  //post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: getDeliveryRequestUrl,
  );

  // decoding the response
  String data = response.body;
  var decodedData = jsonDecode(data);
  // log(decodedData.toString());
  //the response and error handling
  if (decodedData['success'] == true || response.statusCode == 200) {
    final deliveryRequestsList =
        (decodedData['data'] as List).map((e) => OrderModel.fromJson(e)).toList();

    return deliveryRequestsList;
  } else {
    return [];
  }
}

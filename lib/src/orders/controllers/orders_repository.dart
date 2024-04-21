import 'dart:convert';

import 'package:tago/app.dart';
import 'package:http/http.dart' as http;

class OrderRepositories {
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
      orderList.sort((a, b) => b.status!.compareTo(a.status!));
          log('Orders List : $orderList');

      HiveHelper().saveAllOrders(orderList);

// so basically what i am doing here is checking if the ID exists, if no it populates the local storage on HIVE, so on new fetch, it doesn't invalidate an already existing orderList that might have been manipulated by the notification
      orderList.forEach((element) {
        if (HiveHelper().orderListBoxValues().map((e) => e.id).toList().contains(element.id) ==
            false) {
          log('i am saving the elements');

          log('Elements : $element');


          HiveHelper().saveOrderLists(element);
        } else {
          log('Id already exists');
        }
      });
      return orderList;
    } else {
      return [];
    }
  }
/*------------------------------------------------------------------
             GET LIST OF ORDERS METHOD
 -------------------------------------------------------------------*/

  Future<List<OrderListModel>> getListOfOrderByIDMethod({
    bool showSnackBar = false,
    required String id,
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
          .where((element) => element.id == id)
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
      // throw UnimplementedError();
      return [] as OrderListModel;
      // return OrderListModel();
    }
  }

/*------------------------------------------------------------------
             GET THE ROUTE DURATION METHOD
 -------------------------------------------------------------------*/
  Future<int> getRouteDuration(LatLng start, LatLng end) async {
    if (start.latitude.toString().isNotEmpty) {
      // var mode = 'driving';
      final String apiUrl =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$googleAPIKey';

      final Response response = await http.get(
        Uri.parse(apiUrl),
      );
      inspect(response);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final durationInSeconds = await decoded['routes'][0]['legs'][0]['duration']['value'];

        // THE COMMENTED OUT SECTION STILL GIVES YOU THE SAME VALUE BUT IN TEXT LIKE ["2 MINS OR 12 MINS OR 0.5MINS"]
        // final durationInSecs = decoded['routes'][0]['legs'][0]['duration']['text'];
        // log(durationInSecs.toString());
        final durationInMinutes = (durationInSeconds / 60).round();
        return durationInMinutes;
      } else {
        throw Exception('Failed to load route');
      }
    } else {
      throw Exception('the latLng are null');
    }
  }
}

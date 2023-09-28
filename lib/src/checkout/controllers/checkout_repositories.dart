import 'package:tago/app.dart';

/*------------------------------------------------------------------
             GET LIST OF AVAILABLE TIMES METHOD
 -------------------------------------------------------------------*/

Future<List<AvailabilityModel>> getAvailableDatesMethod() async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: getAvailabilityUrl,
  );

  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);
  log('day resposnse status: ${response.statusCode}');
  //the response and error handling
  if (decodedData['success'] == true || response.statusCode == 200) {
    final availableTimes =
        (decodedData['data'] as List).map((e) => AvailabilityModel.fromJson(e)).toList();

    // log('get request for availibilty model:  ${decodedData['data']}');

    return availableTimes;
  } else {
    return [decodedData['message']];
  }
}

// /*------------------------------------------------------------------
//              GET LIST OF AVAILABLE DATE METHOD
//  -------------------------------------------------------------------*/

Future<List<TimesModel>> getAvailableTimesMethod(int index) async {
  // try {
  // post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: getAvailabilityUrl,
  );

  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);
  log('times resposnse status: ${response.statusCode}');

  //the response and error handling
  if (decodedData['success'] == true || response.statusCode == 200) {
    //  if (index != null) {

    //  }
    var availableTimes = (decodedData['data'] as List)[index]['times'];
    var convertedList = convertDynamicListToTimesListModel(availableTimes);
    log('get request for availibilty times:  $availableTimes');

    return convertedList;
  } else {
    return [decodedData['message']];
  }
}

// /*------------------------------------------------------------------
//              GET DELIVERY FEE METHOD
//  -------------------------------------------------------------------*/
Future<String> getDeliveryFeeMethod(
    {required String addressId, required String totalAmount}) async {
  var url = '$checkOutUrl/delivery-fee?addressId=$addressId&totalAmount=$totalAmount';
  final Response response = await NetworkHelper.getRequestWithToken(
    api: url,
  );

  log(url);
  String data = response.body;
  var decodedData = jsonDecode(data);

  // log(decodedData.toString());
  //the response and error handling
  if (decodedData['success'] == true || response.statusCode == 200) {
    // log(' get requests for delivery fee : ${decodedData['data']}');
    return decodedData['data'].toString();
  } else {
    return '0';
  }
}

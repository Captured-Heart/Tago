import 'package:tago/app.dart';

/*------------------------------------------------------------------
             GET LIST OF AVAILABLE TIMES METHOD
 -------------------------------------------------------------------*/

Future<List<AvailabilityModel>> getAvailableTimesMethod() async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: getAvailabilityUrl,
  );

  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);
  //the response and error handling
  if (decodedData['success'] == true || response.statusCode == 200) {
    final availbleTimes =
        (decodedData['data'] as List).map((e) => AvailabilityModel.fromJson(e)).toList();

    log('get request for availibilty model:  ${decodedData['data']}');

    return availbleTimes;
  } else {
    return [decodedData['message']];
  }
}

// /*------------------------------------------------------------------
//              GET LIST OF AVAILABLE DATE METHOD
//  -------------------------------------------------------------------*/

// Future<String> getAvailableDateMethod() async {
//   // try {
//   //post request executed
//   final Response response = await NetworkHelper.getRequestWithToken(
//     api: getAvailabilityUrl,
//   );

//   // decoding the response

//   String data = response.body;
//   var decodedData = jsonDecode(data);
//   //the response and error handling
//   if (decodedData['success'] == true) {
//     final availbleTimes = (decodedData['data']['date'] as String);
//     log('get request for cart model:  ${decodedData['data']}');

//     return availbleTimes;
//   } else {
//     return decodedData['message'];
//   }
// }

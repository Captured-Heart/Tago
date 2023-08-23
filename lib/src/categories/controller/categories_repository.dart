/*------------------------------------------------------------------
fetch Categories
 -------------------------------------------------------------------*/
import 'dart:io';
import 'package:tago/app.dart';
import 'package:tago/core/network/networking.dart';

Future<void> fetchCategoriesMethod() async {
  try {
    //post request executed
    final Response response = await NetworkHelper.getRequest(
      api: getCategories,
    );

    // decoding the response
    String data = response.body;
    var decodedData = jsonDecode(data);
    log('get request for Categories:  $decodedData'); //

    //the response and error handling
    if (decodedData['success'] == 'true') {
      log('get request for Categories:  $decodedData'); //

      return decodedData;
    } else {}
  } on HttpException catch (error) {
    log('http exception: ${error.message}');
  } catch (e) {}
}

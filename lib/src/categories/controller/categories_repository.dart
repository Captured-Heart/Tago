/*------------------------------------------------------------------
fetch Categories
 -------------------------------------------------------------------*/
import 'package:tago/app.dart';
import 'package:tago/core/network/networking.dart';

Future<List<CategoriesModel>> fetchCategoriesMethod() async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequest(
    api: getCategories,
  );

  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);

  //the response and error handling
  if (response.statusCode == 200) {
    // log('get request for Categories:  $decodedData'); //

    final categoriesList = (decodedData['data']['categories'] as List)
        .map((e) => CategoriesModel.fromJson(e))
        .toList();
    log('get request for Categories:  $categoriesList'); //

    return categoriesList;
  } else {
    return decodedData['message'];
  }
}

/*------------------------------------------------------------------
fetch sub Categories
 -------------------------------------------------------------------*/

Future<List<CategoriesModel>> fetchCategoriesByLabel(String label) async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequest(
    api: '$getCategory=$label',
  );

  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);

  //the response and error handling
  if (response.statusCode == 200) {
    // log('get request for Categories:  $decodedData'); //

    final categoriesList = (decodedData['data']['categories'] as List)
        .map((e) => CategoriesModel.fromJson(e))
        .toList();
    log('get request for Categories:  $categoriesList'); //

    return categoriesList;
  } else {
    return decodedData['message'];
  }
}
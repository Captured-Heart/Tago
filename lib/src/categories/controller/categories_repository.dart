import 'package:tago/app.dart';
import 'package:tago/src/categories/model/domain/products_model.dart';

/*------------------------------------------------------------------
              FETCH CATEGORIES METHOD
 -------------------------------------------------------------------*/

Future<List<CategoriesModel>> fetchCategoriesMethod() async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequest(
    api: getCategoriesUrl,
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
                    FETCH CATEGORIES BY LABEL
 -------------------------------------------------------------------*/

Future<List<ProductsModel>> fetchCategoriesByLabel(String label) async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequest(
    api: '$getCategoryUrl=$label',
  );
  log('$getCategoryUrl=$label');
  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);

  //the response and error handling
  if (response.statusCode == 200) {
    // log('get request for Categories:  $decodedData'); //

    final productList = (decodedData['data']['products'] as List)
        .map((e) => ProductsModel.fromJson(e))
        .toList();
    log('get request for Categories by label:  $productList'); //

    return productList;
  } else {
    return decodedData['message'];
  }
}

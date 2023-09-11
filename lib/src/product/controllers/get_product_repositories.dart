import 'package:tago/app.dart';

/*------------------------------------------------------------------
                    FETCH PRODUCTS
 -------------------------------------------------------------------*/

Future<ProductsModel> getProductsMethod(String label) async {
  // try {
  //post request executed
  final Response response = await NetworkHelper.getRequestWithToken(
    api: '$getProductsUrl=$label',
  );
  log('$getCategoryUrl=$label');
  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);

  //the response and error handling
  if (response.statusCode == 200) {
    // log('get request for Categories:  $decodedData'); //

    final productList = ProductsModel.fromJson(decodedData['data']);
    // (decodedData['data'] as List).map((e) => ProductsModel.fromJson(e)).toList();
    log('get request for products by label:  $productList'); //

    return productList;
  } else {
    return decodedData['message'];
  }
}

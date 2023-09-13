import 'package:tago/app.dart';

import '../models/domain/product_specifications_model.dart';

final productSpecificationsProvider =
    StateProvider<List<ProductSpecificationsModel>>(name: 'Product specification', (ref) {
  return [];
});
final relatedProductsProvider = StateProvider<List<ProductsModel>>((ref) {
  return [];
});
/*------------------------------------------------------------------
                    FETCH PRODUCTS
 -------------------------------------------------------------------*/

Future<ProductsModel> getProductsMethod(String label, AutoDisposeFutureProviderRef ref) async {
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
    // log('get request for products by label:  $productList'); //
    ref.read(productSpecificationsProvider.notifier).update((state) =>
        convertDynamicListToProductSpecificationsModel(productList.productSpecification!));
    ref
        .read(relatedProductsProvider.notifier)
        .update((state) => convertDynamicListToProductListModel(productList.relatedProducts!));
    return productList;
  } else {
    return decodedData['message'];
  }
}

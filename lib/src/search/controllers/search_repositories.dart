import 'dart:convert';

import 'package:tago/app.dart';

final fetchSearchStreamProvider = StreamProvider.autoDispose
    .family<List<ProductsModel>, String>((ref, keyWord) async* {
  // final keyWord = ref.watch(searchTextProvider);
  // log('keyWord: $keyWord');
  yield* fetchSearchMethod(keyWord: keyWord);
});
/*------------------------------------------------------------------
                    FETCH SEARCH BY KEYWORDS
 -------------------------------------------------------------------*/

Stream<List<ProductsModel>> fetchSearchMethod({
  required String keyWord,
  String? categoryId,
  List? brandIds,
}) async* {
  // try {
  //post request executed
  var url =
      '$getSearchUrl?keyWord=$keyWord&byCategoryId=$categoryId&byBrandIds=$brandIds';
  final Response response = await NetworkHelper.getRequest(
    api: url,
  );
  log(url);
  // decoding the response

  String data = response.body;
  var decodedData = jsonDecode(data);

  //the response and error handling
  if (response.statusCode == 200) {
    // log('get request for Categories:  $decodedData'); //

    final productList = (decodedData['data'] as List)
        .map((e) => ProductsModel.fromJson(e))
        .toList();
    log('get request for Search by keyWord:  $productList'); //

    yield productList;
  }

  // else {
  //   yield decodedData['message'] as List<ProductsModel>;
  // }
}

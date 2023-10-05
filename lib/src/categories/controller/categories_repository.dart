import 'dart:convert';

import 'package:tago/app.dart';

/*------------------------------------------------------------------
              FETCH CATEGORIES METHOD
 -------------------------------------------------------------------*/

Future<CategoriesGroupModel?> fetchCategoriesMethod() async {
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
    final dealsList = (decodedData['data']['deals'] as List)
        .map((e) => DealsModel.fromJson(e))
        .toList();

    final showcaseProduct = decodedData['data']['showcase'] != null
        ? ProductTagModel.fromJson(decodedData['data']['showcase'])
        : null;

    final categoriesGroup = CategoriesGroupModel(
        categories: categoriesList,
        deals: dealsList,
        showcaseProductTag: showcaseProduct);
    // log('get request for Categories:  $categoriesList'); //

    return categoriesGroup;
    // log('get request for Categories:  $categoriesList'); //
  } else {
    return null;
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
    // log('get request for Categories by label:  $productList'); //

    return productList;
  } else {
    return [];
    // decodedData['message'];
  }
}

/*------------------------------------------------------------------
                    FETCH CATEGORY WITH SUBCATEGORIES BY LABEL
 -------------------------------------------------------------------*/

Future<List<SubCategoryModel>> fetchCategoryWithSubcategoriesByLabel(
    String label) async {
  final Response response = await NetworkHelper.getRequest(
    api: '$getCategoryWithSubcategoriesUrl=$label',
  );

  String data = response.body;
  var decodedData = jsonDecode(data);

  //the response and error handling
  if (response.statusCode == 200) {
    final subCategoryList = (decodedData['data']['subCategories'] as List)
        .map((e) => SubCategoryModel.fromJson(e))
        .toList();

    return subCategoryList;
  } else {
    return [];
  }
}

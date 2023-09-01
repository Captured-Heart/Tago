import 'package:tago/app.dart';
import 'package:tago/src/categories/model/domain/products_model.dart';

List<SubCategoriesModel> convertDynamicListToSubCategoryListModel(
  List<dynamic> dynamicList,
) {
  List<SubCategoriesModel> modelList = [];

  for (var dynamicItem in dynamicList) {
    SubCategoriesModel modelInstance = SubCategoriesModel.fromJson(dynamicItem);

    modelList.add(modelInstance);
  }

  return modelList;
}

List<ProductsModel> convertDynamicListToProductListModel(
  List<dynamic> dynamicList,
) {
  List<ProductsModel> modelList = [];

  for (var dynamicItem in dynamicList) {
    ProductsModel modelInstance = ProductsModel.fromJson(dynamicItem);

    modelList.add(modelInstance);
  }

  return modelList;
}

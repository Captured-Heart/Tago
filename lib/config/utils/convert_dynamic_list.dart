import 'package:tago/app.dart';
import 'package:tago/src/product/models/domain/product_reviews_model.dart';
import 'package:tago/src/product/models/domain/product_specifications_model.dart';

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

List<TimesModel> convertDynamicListToTimesListModel(
  List<dynamic> dynamicList,
) {
  List<TimesModel> modelList = [];

  for (var dynamicItem in dynamicList) {
    TimesModel modelInstance = TimesModel.fromJson(dynamicItem);

    modelList.add(modelInstance);
  }

  return modelList;
}

List<ProductSpecificationsModel> convertDynamicListToProductSpecificationsModel(
  List<dynamic>? dynamicList,
) {
  List<ProductSpecificationsModel> modelList = [];

  for (var dynamicItem in dynamicList ?? []) {
    ProductSpecificationsModel modelInstance = ProductSpecificationsModel.fromJson(dynamicItem);

    modelList.add(modelInstance);
  }

  return modelList;
}

List<ProductReviewsModel> convertDynamicListToProductReviewsModel(
  List<dynamic> dynamicList,
) {
  List<ProductReviewsModel> modelList = [];

  for (var dynamicItem in dynamicList) {
    ProductReviewsModel modelInstance = ProductReviewsModel.fromJson(dynamicItem);

    modelList.add(modelInstance);
  }

  return modelList;
}

int convertTo12Hrs(int timeInInt) {
  if (timeInInt > 12) {
    return timeInInt - 12;
  } else {
    return timeInInt;
  }
}

bool checkIdenticalListsWithInt({
  required List list1,
  required int int,
}) {
  var itemList = list1.contains(int);

  return itemList;
}

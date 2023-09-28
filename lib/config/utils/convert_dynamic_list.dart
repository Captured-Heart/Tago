import 'package:tago/app.dart';

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

List<PlaceOrderModel> convertDynamicListToPlaceOrderModel(
  List<dynamic> dynamicList,
) {
  List<PlaceOrderModel> modelList = [];

  for (var dynamicItem in dynamicList) {
    PlaceOrderModel modelInstance = PlaceOrderModel.fromJson(dynamicItem);

    modelList.add(modelInstance);
  }

  return modelList;
}

List<RiderOrderItemsModel> convertDynamicListToRiderOrderItemModel(
  List<dynamic> dynamicList,
) {
  List<RiderOrderItemsModel> modelList = [];

  for (var dynamicItem in dynamicList) {
    RiderOrderItemsModel modelInstance = RiderOrderItemsModel.fromJson(dynamicItem);

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

double? getAverageOfRatings({
  required List<dynamic>? listOfDoubles,
}) {
  var number = listOfDoubles?.fold(0.0, (previousValue, element) => previousValue + element);
  double finalNumber = (number ?? 0.0) / (listOfDoubles?.length ?? 1);

  return finalNumber;
}

double getPercentageOfReviews({
  required int totalNoOfReviews,
  required int noOfReviews,
}) {
  var perc = noOfReviews / totalNoOfReviews;
  return perc;
}

// i am checking if the ratings has a decimal (e.g: 3.5 == true, i.e if it is false, i can return the same value or approximate)
double ratingsValueExtrapolation(double ratings) {
  if ((ratings != ratings.toInt()) == false) {
    return ratings;
  } else {
    return ratings.roundToDouble();
  }
}

List<dynamic> getListOfIndividualRating({
  required List<dynamic>? listOfDoubles,
  required double ratingsValue,
}) {
  var op = listOfDoubles
          ?.where((element) => element >= ratingsValue && element <= ratingsValue.roundToDouble())
          .map((e) => e.roundToDouble())
          .toList() ??
      [];
  return op;
}

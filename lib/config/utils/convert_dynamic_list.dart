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

// import 'dart:async';

import 'dart:async';

import 'package:tago/app.dart';
/*------------------------------------------------------------------
               CATEGORY WITH SUBCATEGORY BY LABEL NOTIFIER
 -------------------------------------------------------------------*/
class SubCategoryByLabelNotifier extends AsyncNotifier<List<SubCategoryModel>> {
  SubCategoryByLabelNotifier();

  @override
  Future<List<SubCategoryModel>> build() {
    final label = ref.watch(categoryLabelProvider);
    return CategoriesRepository().fetchCategoryWithSubcategoriesByLabel(label);
  }
}
/*------------------------------------------------------------------
               CATEGORY WITH SUBCATEGORY BY LABEL ASYNC PROVIDER
 -------------------------------------------------------------------*/
final fetchCategoryWithSubcategoriesByLabelProvider =
    AsyncNotifierProvider<SubCategoryByLabelNotifier, List<SubCategoryModel>>(() {
  return SubCategoryByLabelNotifier();
});

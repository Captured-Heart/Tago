// import 'dart:async';

import 'dart:async';

import 'package:tago/app.dart';

/*------------------------------------------------------------------
            FETCH  CATEGORY NOTIFIER
 -------------------------------------------------------------------*/
class CategoryListNotifier extends AsyncNotifier<CategoriesGroupModel?> {
  CategoryListNotifier();

  @override
  Future<CategoriesGroupModel?> build() {
    return CategoriesRepository().fetchCategoriesMethod();
  }
}

/*------------------------------------------------------------------
               CATEGORY  ASYNC PROVIDER
 -------------------------------------------------------------------*/
final fetchCategoriesProvider =
    AsyncNotifierProvider<CategoryListNotifier, CategoriesGroupModel?>(() {
  return CategoryListNotifier();
});

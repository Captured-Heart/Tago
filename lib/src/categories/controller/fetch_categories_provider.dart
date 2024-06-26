import 'package:tago/app.dart';

/*------------------------------------------------------------------
              FETCH CATEGORIES PROVIDER
 -------------------------------------------------------------------*/

final fetchCategoriesProvider =
    FutureProvider.autoDispose<CategoriesGroupModel?>((ref) async {
  return fetchCategoriesMethod();
});

/*------------------------------------------------------------------
               CATEGORY BY LABEL PROVIDER
 -------------------------------------------------------------------*/

final fetchCategoryByLabelProvider =
    FutureProvider.autoDispose<List<ProductsModel>>((ref) async {
  final label = ref.watch(categoryLabelProvider);
  return fetchCategoriesByLabel(label);
});

/*------------------------------------------------------------------
               CATEGORY WITH SUBCATEGORY BY LABEL PROVIDER
 -------------------------------------------------------------------*/

final fetchCategoryWithSubcategoriesByLabelProvider =
    FutureProvider.autoDispose<List<SubCategoryModel>>((ref) async {
  final label = ref.watch(categoryLabelProvider);
  return fetchCategoryWithSubcategoriesByLabel(label);
});

/*------------------------------------------------------------------
               CATEGORY INDEX PROVIDER
 -------------------------------------------------------------------*/
final categoryIndexProvider = StateProvider<int>((ref) {
  return 0;
});

/*------------------------------------------------------------------
               CATEGORY LABEL PROVIDER
 -------------------------------------------------------------------*/
final categoryLabelProvider = StateProvider<String>((ref) {
  return '';
});

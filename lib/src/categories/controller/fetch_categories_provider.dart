import 'package:tago/app.dart';

/*------------------------------------------------------------------
              FETCH CATEGORIES PROVIDER
 -------------------------------------------------------------------*/

final fetchCategoriesProvider =
    FutureProvider<List<CategoriesModel>>((ref) async {
  return fetchCategoriesMethod();
});

/*------------------------------------------------------------------
               CATEGORY BY LABEL PROVIDER
 -------------------------------------------------------------------*/

final fetchCategoryByLabelProvider =
    FutureProvider<List<ProductsModel>>((ref) async {
  final label = ref.watch(categoryLabelProvider);
  return fetchCategoriesByLabel(label);
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

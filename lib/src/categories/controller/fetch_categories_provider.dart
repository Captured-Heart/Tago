

/*------------------------------------------------------------------
              FETCH CATEGORIES PROVIDER
 -------------------------------------------------------------------*/

// final fetchCategoriesProvider = FutureProvider.autoDispose<CategoriesGroupModel?>((ref) async {
//   return CategoriesRepository().fetchCategoriesMethod();
// });

/*------------------------------------------------------------------
               CATEGORY BY LABEL PROVIDER
 -------------------------------------------------------------------*/

// final fetchCategoryByLabelProvider = FutureProvider.autoDispose<List<ProductsModel>>((ref) async {
//   final label = ref.watch(categoryLabelProvider);
//   return CategoriesRepository().fetchCategoriesByLabel(label);
// });

/*------------------------------------------------------------------
               CATEGORY WITH SUBCATEGORY BY LABEL PROVIDER
 -------------------------------------------------------------------*/

// final fetchCategoryWithSubcategoriesByLabelProvider =
//     FutureProvider.autoDispose<List<SubCategoryModel>>((ref) async {
//   final label = ref.watch(categoryLabelProvider);
//   return fetchCategoryWithSubcategoriesByLabel(label);
// });

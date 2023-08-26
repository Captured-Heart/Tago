import 'package:tago/app.dart';

final fetchCategoriesProvider =
    FutureProvider<List<CategoriesModel>>((ref) async {
  return fetchCategoriesMethod();
});



final categoryIndexProvider = StateProvider<int>((ref) {
  return 0;
});

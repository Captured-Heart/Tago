import 'package:tago/app.dart';

final getProductsProvider = FutureProvider.autoDispose
    .family<ProductsModel, String>((ref, label) async {
  return getProductsMethod(label, ref);
});

final getProductsByTagProvider = FutureProvider.autoDispose
    .family<List<ProductsModel>, String>((ref, label) async {
  return getProductsByTagMethod(label);
});

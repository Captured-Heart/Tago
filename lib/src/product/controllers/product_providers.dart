import 'package:tago/app.dart';

final getProductsProvider = FutureProvider.autoDispose
    .family<ProductsModel, String>((ref, label) async {
  return getProductsMethod(label);
});

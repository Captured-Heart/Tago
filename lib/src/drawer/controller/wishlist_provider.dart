import 'package:tago/app.dart';

final fetchWishListProvider =
    FutureProvider.autoDispose<List<ProductsModel>>((ref) async {
  return fetchWishListMethod();
});

// final postToWishListProvider =
//     FutureProvider.family.autoDispose<String, Map<String, dynamic>>((ref, map) async {
//   return postToWishListMethod(map: map);
// });

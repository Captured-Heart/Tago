import 'package:tago/app.dart';

final fetchWishListProvider =
    FutureProvider.autoDispose.family<List<ProductsModel>, bool>((ref, showSnackBar) async {
  return fetchWishListMethod(showSnackBar: showSnackBar);
});

// final postToWishListProvider =
//     FutureProvider.family.autoDispose<String, Map<String, dynamic>>((ref, map) async {
//   return postToWishListMethod(map: map);
// });

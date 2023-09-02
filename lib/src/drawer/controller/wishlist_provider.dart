import 'package:tago/app.dart';
import 'package:tago/src/drawer/controller/wishlist_repository.dart';

final wishListProvider = FutureProvider<List<ProductsModel>>((ref) async {
  return fetchWishListMethod();
});

import 'package:tago/app.dart';

final getCartListProvider =
    FutureProvider.autoDispose.family<List<CartModel>, bool>((ref, showSnackBar) async {
  return getCartMethod(showSnackBar: showSnackBar);
});

final cartNotifierProvider =
    StateNotifierProvider<CartMethodNotifier, AsyncValue>((ref) {
  return CartMethodNotifier();
});

import 'package:tago/app.dart';

final getCartListProvider =
    FutureProvider.autoDispose<List<CartModel>>((ref) async {
  return getCartMethod();
});

final cartNotifierProvider =
    StateNotifierProvider<CartMethodNotifier, AsyncValue>((ref) {
  return CartMethodNotifier();
});

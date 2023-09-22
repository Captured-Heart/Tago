import 'package:tago/app.dart';

final orderListProvider = FutureProvider.autoDispose<List<OrderListModel>>((ref) async {
  return getListOfOrderMethod();
});
final orderStatusProvider =
    FutureProvider.autoDispose.family<OrderListModel, String>((ref, orderId) async {
  return getOrderStatusMethod(orderId: orderId);
});

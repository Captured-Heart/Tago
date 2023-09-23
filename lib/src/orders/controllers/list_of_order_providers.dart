import 'package:tago/app.dart';

final orderListProvider = FutureProvider.autoDispose
    .family<List<OrderListModel>, bool>((ref, showSnackBar) async {
  return getListOfOrderMethod(showSnackBar: showSnackBar);
});
final orderListByIDProvider = FutureProvider.autoDispose
    .family<List<OrderListModel>, String>((ref, id) async {
  return getListOfOrderByIDMethod(id: id);
});
final orderStatusProvider = FutureProvider.autoDispose
    .family<OrderListModel, String>((ref, orderId) async {
  return getOrderStatusMethod(orderId: orderId);
});

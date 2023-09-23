import 'package:tago/app.dart';

final deliveryRequestsProvider =
    FutureProvider.autoDispose<List<DeliveryRequestsModel>>((ref) async {
  return getDeliveryRequestsMethod();
});

// final deliveryRequestsProvider = StateNotifierProvider<DeliveryRequestsNotifier, AsyncValue>((ref) {
//   return DeliveryRequestsNotifier();
// });

final ridersOrderProvider =
    FutureProvider.autoDispose<List<OrderListModel>>((ref) async {
  return getRiderListOfOrderMethod();
});

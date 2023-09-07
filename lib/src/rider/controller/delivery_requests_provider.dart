import 'package:tago/app.dart';
import 'package:tago/src/rider/controller/delivery_requests_repositories.dart';

final deliveryRequestsProvider =
    FutureProvider.autoDispose<List<OrderModel>>((ref) async {
  return getDeliveryRequestsMethod();
});

// final deliveryRequestsProvider = StateNotifierProvider<DeliveryRequestsNotifier, AsyncValue>((ref) {
//   return DeliveryRequestsNotifier();
// });

import 'package:tago/app.dart';

/*------------------------------------------------------------------
                GET LIST OF ORDERS BY ID NOTIFIER
 -------------------------------------------------------------------*/

// final getDurationProvider = FutureProvider<int>((ref) async {
//   return OrderRepositories().getRouteDuration(start, end);
// });

final getDurationStreamProvider =
    FutureProvider.family<int, OrderListModel>((ref, orders) async {
  var source = LatLng(orders.fulfillmentHub?.latitude ?? 0, orders.fulfillmentHub?.longitude ?? 0);
  var destination =
      LatLng(orders.address?.metadata?.latitude ?? 0, orders.address?.metadata?.longitude ?? 0);

  return await OrderRepositories().getRouteDuration(source, destination);
});

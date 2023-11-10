import 'package:tago/app.dart';

/*------------------------------------------------------------------
             GET LIST OF ORDERS ASYNC NOTIFIER PROVIDER
 -------------------------------------------------------------------*/
final orderListProvider = AsyncNotifierProviderFamily<GetListOfOrderNotifier,
    List<OrderListModel>, bool>(() {
  return GetListOfOrderNotifier();
});

/*------------------------------------------------------------------
                GET LIST OF ORDERS NOTIFIER
 -------------------------------------------------------------------*/
class GetListOfOrderNotifier
    extends FamilyAsyncNotifier<List<OrderListModel>, bool> {
  @override
  Future<List<OrderListModel>> build(arg) {
    return OrderRepositories().getListOfOrderMethod(showSnackBar: arg);
  }
}

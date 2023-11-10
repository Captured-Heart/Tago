import 'package:tago/app.dart';

/*------------------------------------------------------------------
                GET LIST OF ORDERS BY ID ASYNC NOTIFIER PROVIDER
 -------------------------------------------------------------------*/

final orderListByIDProvider = AsyncNotifierProviderFamily<
    GetListOfOrderByIDNotifier, List<OrderListModel>, String>(() {
  return GetListOfOrderByIDNotifier();
});

/*------------------------------------------------------------------
                GET LIST OF ORDERS BY ID NOTIFIER
 -------------------------------------------------------------------*/
class GetListOfOrderByIDNotifier
    extends FamilyAsyncNotifier<List<OrderListModel>, String> {
  @override
  Future<List<OrderListModel>> build(arg) {
    return OrderRepositories().getListOfOrderByIDMethod(id: arg);
  }
}

import 'package:tago/app.dart';

final searchOrdersProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});
final initialIndexOrdersScreenProvider = StateProvider<int>((ref) {
  return 0;
});

// 0 - pending
// 1 - placed
// 2 - cancelled
// 4&6  - processing
// 7 -  picked up
// 9 - delivered
class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  final TextEditingControllerClass controllerClass = TextEditingControllerClass();


  @override
  Widget build(BuildContext context) {
    final initialIndex = ref.watch(initialIndexOrdersScreenProvider);
    // controllerClass.ordersFocusNode.addListener(() {
    //   if (!controllerClass.ordersFocusNode.hasFocus) {
    //     controllerClass.ordersFocusNode.unfocus();
    //   }
    // });

    // final orderList = ref.watch(orderListProvider(false));
    // HiveHelper().saveOrderLists(orderList.valueOrNull![0]);
    // log(orderList.valueOrNull?.map((e) => e.status).toList().toString() ?? '');
    // log('status: ${orderList.valueOrNull?.map((e) => e.id).toList()}');

    // final orderList = ref.watch(orderListProvider(false));
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: OrdersAppbar(
          controllerClass: controllerClass,
        ),

        // ordersAppbar(
        //   context: context,
        //   isBadgeVisible: checkCartBoxLength()?.isNotEmpty ?? false,
        //   controllerClass: controllerClass,
        //   ref: ref,
        // ),
        body: const TabBarView(
          children: [
            //! active orders
            ActiveOrderScreen(),

            //!completed tab
            CompletedOrderScreen()
          ],
        ),
      ),
    );
  }
}

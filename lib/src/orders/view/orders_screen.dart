import 'package:tago/app.dart';

enum OrderStatus {
  pending(0, TextConstant.pending),
  received(4, TextConstant.received),
  processing(6, TextConstant.processing),
  delivered(9, TextConstant.delivered),
  cancelled(2, TextConstant.cancelled),
  successful(9, TextConstant.successful),
  pickedUp(7, TextConstant.pickedUp),
  placed(1, TextConstant.placed);

  const OrderStatus(this.status, this.message);
  final int status;
  final String message;
}

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
  void initState() {
    controllerClass.ordersFocusNode.unfocus();
    // ref.read(orderListProvider(false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controllerClass.ordersFocusNode.addListener(() {
      if (!controllerClass.ordersFocusNode.hasFocus) {
        controllerClass.ordersFocusNode.unfocus();
      }
    });
    final orderList = ref.watch(orderListProvider(false));
    final cartList = ref.watch(getCartListProvider(false).select((value) => value.valueOrNull));
    log(orderList.valueOrNull?.map((e) => e.status).toList().toString() ?? '');
    log('status: ${orderList.valueOrNull?.map((e) => e.id).toList()}');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
   
        appBar: ordersAppbar(
          context: context,
          isBadgeVisible: cartList?.isNotEmpty ?? false,
          controllerClass: controllerClass,
        ),
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

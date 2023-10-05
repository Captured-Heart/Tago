import 'package:tago/app.dart';

class OrderPlacedScreen extends ConsumerWidget {
  const OrderPlacedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = HiveHelper().getData(HiveKeys.createOrder.keys)['data'];
    var orderId = data['orderId'];
    final orderList = ref.watch(orderListByIDProvider(orderId)).valueOrNull;
    var orderListModel = orderList?.first;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: tagoBackButton(
            context: context,
            onTapBack: () {
              popToMain(context);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            // Text(HiveHelper().getData(HiveKeys.createOrder.keys).toString() ?? 'addacecw'),

            Column(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: TagoLight.primaryColor,
                  size: 48,
                ),
                ListTile(
                  title: const Center(child: Text(TextConstant.orderPlaced))
                      .padOnly(bottom: 10),
                  subtitle: const Center(
                      child: Text(TextConstant.youWillReceiveAnEmail)),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: context.sizeWidth(0.9),
                  child: ElevatedButton(
                    onPressed: () {
                      navBarPush(
                        context: context,
                        screen: OrdersDetailScreen(
                          orderListModel:
                              orderListModel ?? const OrderListModel(),
                          orderStatusFromOrderScreen: orderListModel?.status,
                        ),
                        withNavBar: false,
                      );
                    },
                    child: const Text(TextConstant.seeOrderDetails),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    popToMain(context);
                  },
                  child: const Text(TextConstant.shopForAnotherItem),
                )
              ],
            ),
          ].columnInPadding(40),
        ).padOnly(
          bottom: context.sizeHeight(0.15),
        ));
  }
}

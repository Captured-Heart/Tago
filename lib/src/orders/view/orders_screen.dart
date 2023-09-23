import 'package:tago/app.dart';

enum OrderStatus {
  pending(0),
  received(4),
  processing(6),
  delivered(9),
  cancelled(2),
  successful(9),
  pickedUp(7),
  placed(1);

  const OrderStatus(this.status);
  final int status;
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
  // @override
  // void initState() {
  //   ref.read(orderListProvider(false));
  //   log('on init state');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final orderList = ref.watch(orderListProvider(false));
    final cartList = ref
        .watch(getCartListProvider(false).select((value) => value.valueOrNull));
    // log(orderList.valueOrNull?.map((e) => e.id).toList().toString() ?? '');
    log('status: ${orderList.valueOrNull?.map((e) => e.status).toList()}');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // drawer: tagoHomeDrawer(context),
        appBar: ordersAppbar(
          context: context,
          isBadgeVisible: cartList?.isNotEmpty ?? false,
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 30),
              children: [
                orderList.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.receipt,
                            size: 84,
                            color: TagoLight.textHint,
                          ),
                          Text(
                            TextConstant.youHaveNoActiveOrders,
                            style: context.theme.textTheme.titleLarge?.copyWith(
                              fontWeight: AppFontWeight.w100,
                              fontFamily: TextConstant.fontFamilyLight,
                            ),
                          )
                        ].columnInPadding(20),
                      ).padOnly(top: 50);
                    }
                    return Column(
                      children: List.generate(
                        data.length,
                        (index) {
                          var orderModel = data[index];
                          return GestureDetector(
                            onTap: () {
                              navBarPush(
                                context: context,
                                screen: OrderStatus.delivered.status ==
                                        orderModel.status
                                    ? DeliveryCompleteScreen(
                                        orderListModel: orderModel,
                                      )
                                    : OrdersDetailScreen(
                                        orderListModel: orderModel,
                                        orderStatusFromOrderScreen:
                                            orderModel.status,
                                      ),
                                withNavBar: false,
                              );
                            },
                            child: activeOrdersCard(
                              context: context,
                              orderStatus: orderModel.status ?? 0,
                              orderModel: orderModel,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  error: (error, _) {
                    return Text(error.toString());
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ],
            ),

            //!Second screen ___     //completed tab
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 30),
              children: [
                orderList.when(
                  data: (data) {
                    if (data
                        .map((e) => e.status)
                        .contains(OrderStatus.successful.status)) {
                      return Column(
                        children: List.generate(
                          data.length,
                          (index) {
                            var orderModel = data[index];
                            return GestureDetector(
                              onTap: () {
                                navBarPush(
                                  context: context,
                                  screen: OrderStatus.delivered.status ==
                                          orderModel.status
                                      ? DeliveryCompleteScreen(
                                          orderListModel: orderModel,
                                        )
                                      : OrdersDetailScreen(
                                          orderListModel: orderModel,
                                          orderStatusFromOrderScreen:
                                              orderModel.status,
                                        ),
                                  withNavBar: false,
                                );
                              },
                              child: activeOrdersCard(
                                context: context,
                                orderStatus: orderModel.status ?? 0,
                                orderModel: orderModel,
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.receipt,
                          size: 84,
                          color: TagoLight.textHint,
                        ),
                        Text(
                          TextConstant.youHaveNoCompletedOrders,
                          style: context.theme.textTheme.titleLarge?.copyWith(
                            fontWeight: AppFontWeight.w100,
                            fontFamily: TextConstant.fontFamilyLight,
                          ),
                        )
                      ].columnInPadding(20),
                    ).padOnly(top: 50);
                  },
                  error: (error, _) {
                    return Text(error.toString());
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container activeOrdersCard({
    required BuildContext context,
    required int orderStatus,
    required OrderListModel orderModel,
  }) {
    var product = convertDynamicListToPlaceOrderModel(orderModel.orderItems!);

    getOrderStatusColor(int status) {
      if (status == OrderStatus.cancelled.status) {
        return TagoLight.textError;
      } else if (status == OrderStatus.pending.status) {
        return TagoLight.orange;
      } else {
        return TagoLight.primaryColor;
      }
    }

    getOrderStatusTitle(int status) {
      if (status == OrderStatus.cancelled.status) {
        return TextConstant.cancelled;
      } else if (status == OrderStatus.pending.status) {
        return TextConstant.pending;
      } else if (status == OrderStatus.delivered.status) {
        return TextConstant.delivered;
      } else if (status == OrderStatus.placed.status) {
        return TextConstant.placed;
      } else {
        return TextConstant.processing;
      }
    }

    return Container(
      // height: 250,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.1),
        ),
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: [
          cachedNetworkImageWidget(
            imgUrl: product.first.product?.productImages?.first['image']['url'],
            height: 95,
            width: 100,
          ).padOnly(right: 10),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderModel.name ?? '',
                    style: context.theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: AppFontWeight.w300),
                  ).padOnly(bottom: 5),
                  Text('${TextConstant.orderID}: ${orderModel.id}',
                      style: context.theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: AppFontWeight.w600)),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: getOrderStatusColor(orderStatus).withOpacity(0.1),
                    ),
                    child: Text(
                      // TextConstant.inTransit,
                      getOrderStatusTitle(orderStatus),
                      style: context.theme.textTheme.bodyLarge
                          ?.copyWith(color: getOrderStatusColor(orderStatus)),
                    ),
                  ),
                ].columnInPadding(8)),
          ),
        ],
      ),
    );
  }
}

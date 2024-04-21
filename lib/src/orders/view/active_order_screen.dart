import 'package:tago/app.dart';

class ActiveOrderScreen extends ConsumerStatefulWidget {
  const ActiveOrderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends ConsumerState<ActiveOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final keyWord = ref.watch(searchOrdersProvider);
    return ValueListenableBuilder(
      valueListenable: HiveHelper().getOrdersListListenable(),
      builder: (BuildContext context, Box<OrderListModel> box, Widget? child) {
        List<OrderListModel> ordersList = box.values
            .toList()
            .where((element) =>
                element.status != OrderStatus.delivered.status &&
                element.status != OrderStatus.cancelled.status)
            .toList();
            ordersList.sort((a,b) => b.status!.compareTo(a.status!));

        if (ordersList.isEmpty) {
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
        } else if (keyWord.isNotEmpty) {
          return ListView(
            children: List.generate(
              ordersList.length,
              (index) {
                var orderModel = ordersList[index];
                if (orderModel.name!.toLowerCase().contains(keyWord.toLowerCase())) {
                  return activeOrdersCard(
                    context: context,
                    orderStatus: orderModel.status ?? 0,
                    orderModel: orderModel,
                    onViewDetails: () {
                      navBarPush(
                        context: context,
                        screen: orderModel.status == OrderStatus.delivered.status
                            ? DeliveryCompleteScreen(
                                orderListModel: orderModel,
                              )
                            : OrdersDetailScreen(
                                orderId: orderModel.id!,
                              ),
                        withNavBar: false,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        }

        //
        return ListView.builder(
          itemCount: ordersList.length,
          shrinkWrap: false,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            var orderModel = ordersList[index];

            return activeOrdersCard(
              context: context,
              orderStatus: orderModel.status ?? 0,
              orderModel: orderModel,
              onViewDetails: () {
                inspect(orderModel);

                navBarPush(
                  context: context,
                  screen: orderModel.status == OrderStatus.delivered.status
                      ? DeliveryCompleteScreen(
                          orderListModel: orderModel,
                        )
                      : OrdersDetailScreen(
                          orderId: orderModel.id!,
                        ),
                  withNavBar: false,
                );
              },
            );
          },
        );
      },
    );
  }
}

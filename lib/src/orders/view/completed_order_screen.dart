import 'package:tago/app.dart';

class CompletedOrderScreen extends ConsumerStatefulWidget {
  const CompletedOrderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompletedOrderScreenState();
}

class _CompletedOrderScreenState extends ConsumerState<CompletedOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderList = ref.watch(orderListProvider(false));
    final keyWord = ref.watch(searchOrdersProvider);

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 30),
      children: [
        orderList.when(
          data: (data) {
            var completedList =
                data.where((element) => element.status == OrderStatus.delivered.status).toList();
            if (completedList.isNotEmpty) {
              return Column(
                children: List.generate(
                  completedList.length,
                  (index) {
                    var orderModel = completedList[index];
                    return GestureDetector(
                      onTap: () {
                        navBarPush(
                          context: context,
                          screen: OrderStatus.delivered.status == orderModel.status
                              ? DeliveryCompleteScreen(
                                  orderListModel: orderModel,
                                )
                              : OrdersDetailScreen(
                                  orderListModel: orderModel,
                                  orderStatusFromOrderScreen: orderModel.status,
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
            } else if (keyWord.isNotEmpty) {
              return Column(
                children: List.generate(
                  completedList.length,
                  (index) {
                    var orderModel = completedList[index];

                    if (orderModel.name!.toLowerCase().contains(keyWord.toLowerCase())) {
                      return GestureDetector(
                        onTap: () {
                          navBarPush(
                            context: context,
                            screen: OrderStatus.delivered.status == orderModel.status
                                ? DeliveryCompleteScreen(
                                    orderListModel: orderModel,
                                  )
                                : OrdersDetailScreen(
                                    orderListModel: orderModel,
                                    orderStatusFromOrderScreen: orderModel.status,
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
                    }
                    return const SizedBox.shrink();
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
            return Center(child: Text(NetworkErrorEnums.checkYourNetwork.message));
          },
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ],
    );
  }
}

import 'package:tago/app.dart';

class ActiveOrderScreen extends ConsumerStatefulWidget {
  const ActiveOrderScreen({super.key});
  // final TextEditingControllerClass controllerClass;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends ConsumerState<ActiveOrderScreen> {
  @override
  void initState() {
    ref.read(orderListProvider(false));
    log('message');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderList = ref.watch(orderListProvider(false));

    final keyWord = ref.watch(searchOrdersProvider);
    return ListView(
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
            } else if (keyWord.isNotEmpty) {
              return Column(
                children: List.generate(
                  data.length,
                  (index) {
                    var orderModel = data[index];
                    if (orderModel.name!.toLowerCase().contains(keyWord.toLowerCase())) {
                      return GestureDetector(
                        onTap: () {
                          log(orderModel.status.toString());
                          navBarPush(
                            context: context,
                            screen: orderModel.status == OrderStatus.delivered.status
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
              children: List.generate(
                data.length,
                (index) {
                  var orderModel = data[index];
                  return GestureDetector(
                    onTap: () {
                      log(orderModel.status.toString());
                      navBarPush(
                        context: context,
                        screen: orderModel.status == OrderStatus.delivered.status
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
          },
          error: (error, _) {
            return Center(child: Text(NetworkErrorEnums.checkYourNetwork.message));
          },
          loading: () => Column(
            children: List.generate(
              4,
              (index) => orderWidgetLoaders(context),
            ),
          ),
        ),
      ],
    );
  }
}

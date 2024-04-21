import 'package:tago/app.dart';

class CompletedOrderScreen extends ConsumerStatefulWidget {
  const CompletedOrderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompletedOrderScreenState();
}

class _CompletedOrderScreenState extends ConsumerState<CompletedOrderScreen> {
  @override
  Widget build(BuildContext context) {
    // final orderList = ref.watch(orderListProvider(false));
    final keyWord = ref.watch(searchOrdersProvider);
    return ValueListenableBuilder(
      valueListenable: HiveHelper().getOrdersListListenable(),
      builder: (BuildContext context, Box<OrderListModel> box, Widget? child) {
        // if (HiveHelper().getRecentlyViewed() != null) {
        List<OrderListModel> ordersList = box.values.toList();
        var completedList =
            ordersList.where((element) => element.status == OrderStatus.delivered.status).toList();
        if (completedList.isEmpty) {
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
        } else if (keyWord.isNotEmpty) {
          return ListView(
            children: List.generate(
              box.length,
              (index) {
                var orderModel = completedList[index];
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

                                // order: orderModel,
                                // orderStatusFromOrderScreen: orderModel.status,
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
          itemCount: completedList.length,
          shrinkWrap: false,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            // products.sort((a, b) => b.date!.compareTo(a.date!));
            var orderModel = completedList[index];

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

                          // order: orderModel,
                          // orderStatusFromOrderScreen: orderModel.status,
                        ),
                  withNavBar: false,
                );
              },
            );
          },
        );
      },
    );
    // return ListView(
    //   padding: const EdgeInsets.symmetric(vertical: 30),
    //   children: [
    //     orderList.when(
    //       data: (data) {
    //         var completedList =
    //             data.where((element) => element.status == OrderStatus.delivered.status).toList();
    //         if (completedList.isNotEmpty) {
    //           return Column(
    //             children: List.generate(
    //               completedList.length,
    //               (index) {
    //                 var orderModel = completedList[index];
    //                 return GestureDetector(
    //                   onTap: () {
    //                     navBarPush(
    //                       context: context,
    //                       screen: OrderStatus.delivered.status == orderModel.status
    //                           ? DeliveryCompleteScreen(
    //                               orderListModel: orderModel,
    //                             )
    //                           : OrdersDetailScreen(
    //                               order: orderModel,
    //                               orderStatusFromOrderScreen: orderModel.status,
    //                             ),
    //                       withNavBar: false,
    //                     );
    //                   },
    //                   child: activeOrdersCard(
    //                     context: context,
    //                     orderStatus: orderModel.status ?? 0,
    //                     orderModel: orderModel,
    //                     onViewDetails: () {},
    //                   ),
    //                 );
    //               },
    //             ),
    //           );
    //         } else if (keyWord.isNotEmpty) {
    //           return Column(
    //             children: List.generate(
    //               completedList.length,
    //               (index) {
    //                 var orderModel = completedList[index];

    //                 if (orderModel.name!.toLowerCase().contains(keyWord.toLowerCase())) {
    //                   return GestureDetector(
    //                     onTap: () {
    //                       navBarPush(
    //                         context: context,
    //                         screen: OrderStatus.delivered.status == orderModel.status
    //                             ? DeliveryCompleteScreen(
    //                                 orderListModel: orderModel,
    //                               )
    //                             : OrdersDetailScreen(
    //                                 order: orderModel,
    //                                 orderStatusFromOrderScreen: orderModel.status,
    //                               ),
    //                         withNavBar: false,
    //                       );
    //                     },
    //                     child: activeOrdersCard(
    //                       context: context,
    //                       orderStatus: orderModel.status ?? 0,
    //                       orderModel: orderModel,
    //                       onViewDetails: () {},
    //                     ),
    //                   );
    //                 }
    //                 return const SizedBox.shrink();
    //               },
    //             ),
    //           );
    //         }
    //         return Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const Icon(
    //               FontAwesomeIcons.receipt,
    //               size: 84,
    //               color: TagoLight.textHint,
    //             ),
    //             Text(
    //               TextConstant.youHaveNoCompletedOrders,
    //               style: context.theme.textTheme.titleLarge?.copyWith(
    //                 fontWeight: AppFontWeight.w100,
    //                 fontFamily: TextConstant.fontFamilyLight,
    //               ),
    //             )
    //           ].columnInPadding(20),
    //         ).padOnly(top: 50);
    //       },
    //       error: (error, _) {
    //         return Center(child: Text(NetworkErrorEnums.checkYourNetwork.message));
    //       },
    //       loading: () => Column(
    //         children: List.generate(
    //           4,
    //           (index) => orderWidgetLoaders(context),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}

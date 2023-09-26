import 'package:tago/app.dart';
import 'package:tago/src/rider/views/active_delivery_screen.dart';

class DeliveryRequestScreen extends ConsumerStatefulWidget {
  const DeliveryRequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeliveryRequestScreenState();
}

class _DeliveryRequestScreenState extends ConsumerState<DeliveryRequestScreen> {
  @override
  void initState() {
    ref.read(deliveryRequestsProvider);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deliveryRequests = ref.watch(deliveryRequestsProvider);
    final isLoading = ref.watch(riderAcceptDeclineNotifierProvider).isLoading;
   
    log(deliveryRequests.valueOrNull!.map((e) => e.status).toList().toString());
    return FullScreenLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: appBarWidget(
          context: context,
          title: TextConstant.deliveryRequests,
          isLeading: true,
          centerTitle: false,
        ),
        body: ListView(
          children: [
            deliveryRequests.when(
              data: (data) {
                return Column(
                  children: List.generate(
                    data.length,
                    (index) {
                      var riderOrder = data[index];

                      var riderOrderItemModel = convertDynamicListToRiderOrderItemModel(
                          data[index].order?.orderItems ?? []);
                      return riderOrdersListTile(
                        context: context,
                        orderStatus: OrderStatus.delivered,
                        isDeliveryRequests: true,
                        riderOrderModel: riderOrder,
                        riderOrder: riderOrderItemModel,
                        onAcceptRequest: () {
                          ref
                              .read(riderAcceptDeclineNotifierProvider.notifier)
                              .riderAcceptReqestMethod(
                            map: {
                              HiveKeys.createOrder.keys: riderOrder.order?.id,
                            },
                            onNavigation: () {
                              ref.invalidate(deliveryRequestsProvider);
                            },
                          );
                        },
                        onViewDetails: () {
                          log(riderOrder.status.toString());

                          riderOrder.status == 1
                              ? push(
                                  context,
                                  ActiveDeliveryScreen(
                                    riderOrderModel: riderOrderItemModel,
                                    riderOrder: riderOrder,
                                  ),
                                )
                              : push(
                                  context,
                                  NewDeliveryRequestScreen(
                                    riderOrderModel: riderOrderItemModel,
                                    riderOrder: riderOrder,
                                  ),
                                );
                        },
                      );
                    },
                  ),
                );
              },
              error: (error, _) => Center(
                child: Text(error.toString()),
              ),
              loading: () => riderOrdersListTileLoaders(
                context: context,
                index: 3,
              ),
            ),

            // riderOrdersListTile(
            //   context: context,
            //   orderStatus: OrderStatus.delivered,
            //   isDeliveryRequests: true,
            // ),
            // riderOrdersListTile(
            //   context: context,
            //   orderStatus: OrderStatus.delivered,
            //   isDeliveryRequests: true,
            // )
          ],
        ),
      ),
    );
  }
}

import 'package:tago/app.dart';
import 'package:tago/src/rider/views/active_delivery_screen.dart';

class DeliveryRequestScreen extends ConsumerStatefulWidget {
  const DeliveryRequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeliveryRequestScreenState();
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
                      var deliveryRequest = data[index];

                      // var riderOrderItemModel =
                      //     convertDynamicListToRiderOrderItemModel(
                      //         data[index].order?.orderItems ?? []);

                      return riderOrdersListTile(
                        context: context,
                        orderStatus: OrderStatus.delivered,
                        isDeliveryRequests: true,
                        riderOrderModel: deliveryRequest,
                        riderOrder: deliveryRequest.order!.orderItems,
                        onAcceptRequest: () {
                          ref
                              .read(riderAcceptDeclineNotifierProvider.notifier)
                              .riderAcceptReqestMethod(
                            map: {
                              HiveKeys.orderId.keys: deliveryRequest.order?.id,
                            },
                            onNavigation: () {
                              ref.invalidate(deliveryRequestsProvider);
                            },
                          );
                        },
                        onViewDetails: () {
                          push(
                            context,
                            NewDeliveryRequestScreen(
                              request: deliveryRequest,
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
          ],
        ),
      ),
    );
  }
}

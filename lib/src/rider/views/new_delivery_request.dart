import 'package:tago/app.dart';

class NewDeliveryRequestScreen extends ConsumerStatefulWidget {
  const NewDeliveryRequestScreen({
    super.key,
    required this.riderOrderModel,
    required this.riderOrder,
  });
  final List<RiderOrderItemsModel> riderOrderModel;
  final DeliveryRequestsModel? riderOrder;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewDeliveryRequestScreenState();
}

class _NewDeliveryRequestScreenState extends ConsumerState<NewDeliveryRequestScreen> {
  @override
  void initState() {
    ref.read(getCurrentLocationProvider);
    super.initState();
  }

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var orders = widget.riderOrder?.order;
    var address = orders?.address;
    var fulfillmentHub = orders?.fulfillmentHub;
    final currentPosition = ref.watch(getCurrentLocationProvider);
    final isLoading = ref.watch(riderAcceptDeclineNotifierProvider).isLoading;
    // log(orders!.toString());
    log(widget.riderOrder!.status.toString());
    return FullScreenLoader(
      isLoading: isLoading,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  // SliverAppBar is a flexible app bar that can expand and contract
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: context.sizeHeight(0.4), // Set the height when expanded
                    floating: false, // The app bar won't float as the user scrolls
                    pinned: true, // The app bar is pinned to the top
                    flexibleSpace: Column(
                      children: [
                        appBarWidget(
                          context: context,
                          title: TextConstant.newDeliveryRequests,
                          centerTitle: false,
                          isLeading: true,
                        ),
                        Expanded(
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                currentPosition.value?.latitude ?? 20,
                                currentPosition.value?.longitude ?? 12.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Column(
                      children: List.generate(
                        widget.riderOrderModel.length,
                        (index) {
                          var riderOrderDetails = widget.riderOrderModel[index];
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 5),
                            leading: cachedNetworkImageWidget(
                              imgUrl: riderOrderDetails.product?.productImages?.first['image']
                                  ['url'],
                              height: 100,
                              width: 100,
                            ),
                            title: Text(
                              riderOrderDetails.product?.name ?? TextConstant.product,
                              textAlign: TextAlign.left,
                            ),
                            shape: const Border(bottom: BorderSide(width: 0.1)),
                          ).padOnly(bottom: 8);
                        },
                      ),
                    ).padOnly(top: 5, left: 10),
                  ),

                  SliverToBoxAdapter(
                    child: riderDeliveringToWidget(context, orders!),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        riderDeliveryRequestListTile(
                          fulfillmentHub: fulfillmentHub,
                          context: context,
                          icon: Icons.pedal_bike,
                          title: TextConstant.pickupLocation,
                          subtitle1: ' ${fulfillmentHub?.address}',
                          subtitle2: '${fulfillmentHub?.position ?? 0} km away',
                        ),

                        //delivery location
                        riderDeliveryRequestListTile(
                          fulfillmentHub: fulfillmentHub,
                          context: context,
                          icon: Icons.location_on,
                          title: TextConstant.deliveryLocation,
                          subtitle1:
                              ' ${address?.apartmentNumber} ${address?.streetAddress}, ${address?.city}, ${address?.state} ',
                          subtitle2: '${address?.position ?? 0}km away',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            widget.riderOrder!.status! > 0
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      SizedBox(
                        width: context.sizeWidth(0.9),
                        child: ElevatedButton(
                          onPressed: () {
                            ref
                                .read(riderAcceptDeclineNotifierProvider.notifier)
                                .riderAcceptReqestMethod(
                              map: {
                                HiveKeys.createOrder.keys: orders.id,
                              },
                              onNavigation: () {
                                ref.invalidate(deliveryRequestsProvider);

                                pop(context);
                              },
                            );
                          },
                          child: const Text(TextConstant.acceptRequest),
                        ),
                      ),
                      SizedBox(
                        width: context.sizeWidth(0.9),
                        child: ElevatedButton(
                          onPressed: () {
                            ref
                                .read(riderAcceptDeclineNotifierProvider.notifier)
                                .riderDeleteReqestMethod(
                              map: {
                                HiveKeys.createOrder.keys: orders.id,
                              },
                              onNavigation: () {
                                ref.invalidate(deliveryRequestsProvider);
                              },
                            );
                            ref.invalidate(deliveryRequestsProvider);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            foregroundColor: TagoLight.textError.withOpacity(0.8),
                            backgroundColor: TagoLight.textError.withOpacity(0.1),
                          ),
                          child: const Text(TextConstant.decline),
                        ),
                      ),
                    ].columnInPadding(10),
                  ).padOnly(bottom: 30, top: 5)
          ],
        ),
      ),
    );
  }
}

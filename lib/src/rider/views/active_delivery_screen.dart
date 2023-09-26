import 'package:tago/app.dart';

class ActiveDeliveryScreen extends ConsumerStatefulWidget {
  const ActiveDeliveryScreen({
    super.key,
    required this.riderOrderModel,
    required this.riderOrder,
  });
  final List<RiderOrderItemsModel> riderOrderModel;
  final DeliveryRequestsModel? riderOrder;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActiveDeliveryScreenState();
}

class _ActiveDeliveryScreenState extends ConsumerState<ActiveDeliveryScreen> {
  @override
  void initState() {
    ref.read(getCurrentLocationProvider);
    super.initState();
  }

  bool isFaded({required int status, required OrderStatus orderStatus}) {
    if (orderStatus.status == status || orderStatus.status <= status) {
      return false;
    } else {
      return true;
    }
  }

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var orders = widget.riderOrder?.order;
    var address = orders?.address;
    var fulfillmentHub = orders?.fulfillmentHub;
    final currentPosition = ref.watch(getCurrentLocationProvider);
    final isLoading = ref.watch(riderAcceptDeclineNotifierProvider).isLoading;
    final orderList = ref.watch(ridersOrderProvider).valueOrNull;
    var checkedID = orderList?.where((element) => element.id == orders?.id).single;
    log(checkedID!.status.toString());
    // log(widget.riderOrder!.order!.id.toString());
    // log(widget.riderOrder!.status.toString());
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
                          title: TextConstant.activeDelivery,
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
                          bTNText: checkedID.status == 7
                              ? TextConstant.pickedUp
                              : TextConstant.iHavePickedUp,
                          subtitle1: ' ${fulfillmentHub?.address}',
                          subtitle2: '${fulfillmentHub?.position ?? 0} km away',
                          hasButton: true,
                          isFaded: false,
                          isPickedUp: checkedID.status! >= 7 ? true : false,
                          //pick up btn
                          onTap: () {
                            if (checkedID.status != 7) {
                              ref
                                  .read(riderAcceptDeclineNotifierProvider.notifier)
                                  .riderPickUpMethod(
                                onNavigation: () {
                                  ref.invalidate(deliveryRequestsProvider);
                                  ref.invalidate(ridersOrderProvider);
                                },
                                map: {HiveKeys.createOrder.keys: orders.id},
                              );
                            }
                          },
                        ),

                        //delivery location
                        riderDeliveryRequestListTile(
                          fulfillmentHub: fulfillmentHub,
                          context: context,
                          icon: Icons.location_on,
                          title: TextConstant.delivery,
                          bTNText: TextConstant.complete,
                          subtitle1:
                              ' ${address?.apartmentNumber} ${address?.streetAddress}, ${address?.city}, ${address?.state} ',
                          subtitle2: '${address?.position ?? 0}km away',
                          hasButton: true,
                          isFaded: checkedID.status! >= 7 ? false : true,
                          isPickedUp: checkedID.status! > 7 ? true : false,

                          //complete btn
                          onTap: () {
                            if (checkedID.status == 7) {
                              ref
                                  .read(riderAcceptDeclineNotifierProvider.notifier)
                                  .riderDeliveredMethod(
                                onNavigation: () {
                                  ref.invalidate(deliveryRequestsProvider);
                                  ref.invalidate(ridersOrderProvider);
                                },
                                map: {HiveKeys.createOrder.keys: orders.id},
                              );
                            }
                          },
                        ),
                      ].columnInPadding(8),
                    ).padOnly(left: 15),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

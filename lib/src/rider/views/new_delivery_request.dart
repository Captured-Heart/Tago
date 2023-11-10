import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:tago/app.dart';

class NewDeliveryRequestScreen extends ConsumerStatefulWidget {
  const NewDeliveryRequestScreen({
    super.key,
    required this.request,
  });
  final DeliveryRequestsModel? request;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewDeliveryRequestScreenState();
}

class _NewDeliveryRequestScreenState
    extends ConsumerState<NewDeliveryRequestScreen> {
  @override
  void initState() {
    ref.read(getCurrentLocationProvider);
    super.initState();
  }

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var order = widget.request?.order;
    var orderItems = widget.request!.order!.orderItems;
    var address = order?.address;
    var fulfillmentHub = order?.fulfillmentHub;
    final currentPosition = ref.watch(getCurrentLocationProvider);
    final isLoading = ref.watch(riderAcceptDeclineNotifierProvider).isLoading;

    var pickupLocationDistance = Geolocator.distanceBetween(
            fulfillmentHub!.latitude,
            fulfillmentHub.longitude,
            currentPosition.value?.latitude ?? 0,
            currentPosition.value?.longitude ?? 0) /
        1000;

    var deliveryLocationDistance = Geolocator.distanceBetween(
            address!.metadata?.latitude ?? 0,
            address.metadata?.longitude ?? 0,
            currentPosition.value?.latitude ?? 0,
            currentPosition.value?.longitude ?? 0) /
        1000;

    return FullScreenLoader(
      isLoading: isLoading,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: context.sizeHeight(0.6),
                    floating: true,
                    pinned: true,
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
                            myLocationEnabled: true,
                            scrollGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            zoomGesturesEnabled: true,
                            gestureRecognizers: Set()
                              ..add(Factory<VerticalDragGestureRecognizer>(
                                  () => VerticalDragGestureRecognizer())),
                            initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  currentPosition.value?.latitude ?? 0,
                                  currentPosition.value?.longitude ?? 0,
                                ),
                                zoom: 19.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: List.generate(
                        orderItems!.length,
                        (index) {
                          var item = orderItems[index];
                          return ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5),
                            leading: cachedNetworkImageWidget(
                              imgUrl: item.product?.productImages
                                  ?.first['image']['url'],
                              height: 100,
                              width: 100,
                            ),
                            title: Text(
                              item.product?.name ?? TextConstant.product,
                              textAlign: TextAlign.left,
                            ),
                            shape: const Border(bottom: BorderSide(width: 0.1)),
                          ).padOnly(bottom: 8);
                        },
                      ),
                    ).padOnly(top: 5, left: 10),
                  ),
                  SliverToBoxAdapter(
                    child: riderDeliveringToWidget(context, order!.user!),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        riderDeliveryRequestListTile(
                          fulfillmentHub: fulfillmentHub,
                          context: context,
                          icon: Icons.pedal_bike,
                          title: TextConstant.pickupLocation,
                          subtitle1: ' ${fulfillmentHub.address}',
                          subtitle2:
                              '${pickupLocationDistance.toStringAsFixed(0)}Km away',
                        ),

                        //delivery location
                        riderDeliveryRequestListTile(
                          fulfillmentHub: fulfillmentHub,
                          context: context,
                          icon: Icons.location_on,
                          title: TextConstant.deliveryLocation,
                          subtitle1:
                              ' ${address.apartmentNumber} ${address.streetAddress}, ${address.city}, ${address.state} ',
                          subtitle2:
                              '${deliveryLocationDistance.toStringAsFixed(0)}Km away',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            widget.request!.status! > 0
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      SizedBox(
                        width: context.sizeWidth(0.9),
                        child: ElevatedButton(
                          onPressed: () {
                            ref
                                .read(
                                    riderAcceptDeclineNotifierProvider.notifier)
                                .riderAcceptReqestMethod(
                              map: {
                                HiveKeys.orderId.keys: order.id,
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
                                .read(
                                    riderAcceptDeclineNotifierProvider.notifier)
                                .riderDeleteReqestMethod(
                              map: {
                                HiveKeys.orderId.keys: order.id,
                              },
                              onNavigation: () {
                                ref.invalidate(deliveryRequestsProvider);
                                pop(context);
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            foregroundColor:
                                TagoLight.textError.withOpacity(0.8),
                            backgroundColor:
                                TagoLight.textError.withOpacity(0.1),
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

import 'package:tago/app.dart';

class NewDeliveryRequestScreen extends ConsumerStatefulWidget {
  const NewDeliveryRequestScreen({
    super.key,
    required this.riderOrderModel,
    required this.orders,
  });
  final List<RiderOrderItemsModel> riderOrderModel;
  final OrderModel? orders;
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
    var address = widget.orders?.address;
    var fulfillmentHub = widget.orders?.fulfillmentHub;
    final currentPosition = ref.watch(getCurrentLocationProvider);
    return Scaffold(
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
                        ).debugBorder(),
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
                            imgUrl: riderOrderDetails.product?.productImages?.first['image']['url'],
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
                  ),
                ),

                SliverToBoxAdapter(
                  child: riderDeliveringToWidget(context),
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
          Column(
            children: [
              SizedBox(
                width: context.sizeWidth(0.9),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(TextConstant.acceptRequest),
                ),
              ),
              SizedBox(
                width: context.sizeWidth(0.9),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: TagoLight.textError.withOpacity(0.8),
                    backgroundColor: TagoLight.textError.withOpacity(0.1),
                  ),
                  child: const Text(TextConstant.saveandContinue),
                ),
              ),
            ].columnInPadding(10),
          ).padOnly(bottom: 30, top: 5)
        ],
      ),
      // Column(
      //   // padding: const EdgeInsets.symmetric(horizontal: 20),
      //   children: [
      //     Expanded(
      //       child: GoogleMap(
      //         initialCameraPosition: CameraPosition(
      //           target: LatLng(
      //             currentPosition.value?.latitude ?? 20,
      //             currentPosition.value?.longitude ?? 12.2,
      //           ),
      //         ),
      //       ).debugBorder(),
      //     ),

      //     //
      //     SizedBox(
      //       height: context.sizeHeight(0.47),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         // padding: const EdgeInsets.symmetric(horizontal: 20),

      //         children: [
      //           Expanded(
      //               child: Scrollbar(
      //             controller: scrollController,
      //             interactive: true,
      //             child: ListView(
      //               controller: scrollController,
      //               padding: const EdgeInsets.symmetric(vertical: 16),
      //               children: [
      //                 Column(
      //                   children: List.generate(
      //                     widget.riderOrderModel.length,
      //                     (index) {
      //                       var riderOrderDetails = widget.riderOrderModel[index];
      //                       return ListTile(
      //                         contentPadding: const EdgeInsets.symmetric(vertical: 5),
      //                         leading: cachedNetworkImageWidget(
      //                           imgUrl: riderOrderDetails.product?.productImages?.first['image']
      //                               ['url'],
      //                           height: 100,
      //                           width: 100,
      //                         ),
      //                         title: Text(
      //                           riderOrderDetails.product?.name ?? TextConstant.product,
      //                           textAlign: TextAlign.left,
      //                         ),
      //                         shape: const Border(bottom: BorderSide(width: 0.1)),
      //                       ).padOnly(bottom: 8);
      //                     },
      //                   ),
      //                 ),

      //                 //delivering to
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   mainAxisSize: MainAxisSize.min,
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       TextConstant.deliveringTo,
      //                       textAlign: TextAlign.left,
      //                       style: context.theme.textTheme.bodyLarge,
      //                     ),
      //                     ListTile(
      //                       // dense: true,
      //                       contentPadding: EdgeInsets.zero,
      //                       title: Text(
      //                         '${widget.orders?.user?.fname} ${widget.orders?.user?.lname}',
      //                         textAlign: TextAlign.left,
      //                       ),
      //                       subtitle: Text(widget.orders?.user?.phoneNumber ?? ''),
      //                       trailing: IconButton(
      //                         onPressed: () {},
      //                         icon: const Icon(
      //                           Icons.phone,
      //                           color: TagoLight.primaryColor,
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 //pick up location
      //                 riderDeliveryRequestListTile(
      //                   fulfillmentHub: fulfillmentHub,
      //                   context: context,
      //                   icon: Icons.pedal_bike,
      //                   title: TextConstant.pickupLocation,
      //                   subtitle1: ' ${fulfillmentHub?.address}',
      //                   subtitle2: '${fulfillmentHub?.position ?? 0} km away',
      //                 ),

      //                 //delivery location
      //                 riderDeliveryRequestListTile(
      //                   fulfillmentHub: fulfillmentHub,
      //                   context: context,
      //                   icon: Icons.location_on,
      //                   title: TextConstant.deliveryLocation,
      //                   subtitle1:
      //                       ' ${address?.apartmentNumber} ${address?.streetAddress}, ${address?.city}, ${address?.state} ',
      //                   subtitle2: '${address?.position ?? 0}km away',
      //                 ),
      //               ].columnInPadding(10),
      //             ),
      //           )),
      //           Column(
      //             children: [
      //               SizedBox(
      //                 width: context.sizeWidth(0.9),
      //                 child: ElevatedButton(
      //                   onPressed: () {},
      //                   child: const Text(TextConstant.acceptRequest),
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: context.sizeWidth(0.9),
      //                 child: ElevatedButton(
      //                   onPressed: () {},
      //                   style: ElevatedButton.styleFrom(
      //                     elevation: 0,
      //                     foregroundColor: TagoLight.textError.withOpacity(0.8),
      //                     backgroundColor: TagoLight.textError.withOpacity(0.1),
      //                   ),
      //                   child: const Text(TextConstant.saveandContinue),
      //                 ),
      //               ), 
      //             ].columnInPadding(10),
      //           ).padOnly(bottom: 30, top: 5)
      //         ],
      //       ).padSymmetric(horizontal: 20),
      //     ),
      //   ],
      // ),
    );
  }

  Widget riderDeliveringToWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          TextConstant.deliveringTo,
          textAlign: TextAlign.left,
          style: context.theme.textTheme.bodyLarge,
        ),
        ListTile(
          // dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            '${widget.orders?.user?.fname} ${widget.orders?.user?.lname}',
            textAlign: TextAlign.left,
          ),
          subtitle: Text(widget.orders?.user?.phoneNumber ?? ''),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.phone,
              color: TagoLight.primaryColor,
            ),
          ),
        ),
      ],
    ).padSymmetric(horizontal: 20, vertical: 10);
  }

  ListTile riderDeliveryRequestListTile({
    required FulfillmentHubModel? fulfillmentHub,
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle1,
    required String subtitle2,
  }) {
    return ListTile(
      minVerticalPadding: 20,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: TagoLight.primaryColor,
          ),
        ],
      ),
      minLeadingWidth: 10,
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle1,
            style: context.theme.textTheme.bodyLarge,
          ).padSymmetric(vertical: 8),
          //TODO: COMPARE THIS POSITION WITH CURRENT POSITION TO FIND THE DIFFERENCE IN KM
          Text(
            subtitle2,
            style: context.theme.textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}

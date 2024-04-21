import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tago/app.dart';

final hideMapNavBarProvider = StateProvider<bool>((ref) {
  return false;
});

class ActiveDeliveryScreenNew extends ConsumerStatefulWidget {
  const ActiveDeliveryScreenNew({
    super.key,
    required this.order,
  });
  final OrderListModel order;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActiveDeliveryScreenNewState();
}

class _ActiveDeliveryScreenNewState extends ConsumerState<ActiveDeliveryScreenNew> {
  late GoogleMapController _googleMapController;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  OrderListModel? checkedID;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 30,
  );

  @override
  void initState() {
    super.initState();

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) async {
      await Future.delayed(const Duration(seconds: 10));
      log("update");
      await updateCurrentLocation(position!);
      _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 19)));

      setPolyLine();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.order.status == 7) {
        loadPolyLine();
      }
    });
  }

  getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(widget.order.address!.metadata!.latitude ?? 0,
          widget.order.address!.metadata!.longitude ?? 0),
      PointLatLng(widget.order.fulfillmentHub!.latitude, widget.order.fulfillmentHub!.longitude),
      travelMode: TravelMode.driving,
    );
    print("result" + result.toString());
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
  }

  setPolyLine() {
    setState(() {
      Polyline polyline1 = Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinates,
          color: const Color.fromRGBO(0, 0, 0, 1),
          width: 8);

      Polyline polyline2 = Polyline(
          polylineId: const PolylineId("route2"),
          points: polylineCoordinates,
          color: Colors.blueAccent,
          width: 6);
      _polylines.add(polyline1);
      _polylines.add(polyline2);
    });
    _setMapFitToTour(_polylines);
  }

  void _setMapFitToTour(Set<Polyline> p) {
    double minLat = p.first.points.first.latitude;
    double minLong = p.first.points.first.longitude;
    double maxLat = p.first.points.first.latitude;
    double maxLong = p.first.points.first.longitude;

    p.forEach((poly) {
      poly.points.forEach((point) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      });
    });
    _googleMapController.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(southwest: LatLng(minLat, minLong), northeast: LatLng(maxLat, maxLong)), 20));
  }

  loadPolyLine() {
    getPolyline().then((_) => setPolyLine());
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = ref.watch(getCurrentLocationProvider);
    final isLoading = ref.watch(riderAcceptDeclineNotifierProvider).isLoading;
    final orderList = ref.watch(ridersOrderProvider).valueOrNull;
    checkedID = orderList?.where((element) => element.id == widget.order.id).single;

    var pickupLocationDistance = Geolocator.distanceBetween(
          widget.order.fulfillmentHub!.latitude,
          widget.order.fulfillmentHub!.longitude,
          currentPosition.value?.latitude ?? 0,
          currentPosition.value?.longitude ?? 0,
        ) /
        1000;

    var deliveryLocationDistance = Geolocator.distanceBetween(
          widget.order.address!.metadata?.latitude ?? 0,
          widget.order.address!.metadata?.longitude ?? 0,
          currentPosition.value?.latitude ?? 0,
          currentPosition.value?.longitude ?? 0,
        ) /
        1000;

    final hideAppBar = ref.watch(hideMapNavBarProvider);
    return Scaffold(
      appBar: hideAppBar == true
          ? null
          : appBarWidget(
              context: context,
              title: TextConstant.activeDelivery,
              centerTitle: false,
              isLeading: true,
            ),
      body: Stack(
        children: [
          SlidingUpPanel(
            header: hideAppBar == false
                ? null
                : SizedBox(
                    width: context.sizeWidth(1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                          height: 5,
                          width: 60,
                          alignment: Alignment.center,
                        ),
                        // Spacer(),
                      ],
                    ),
                  ).padOnly(top: 10),
            defaultPanelState: PanelState.OPEN,
            color: context.theme.scaffoldBackgroundColor,
            parallaxEnabled: true,
            panelSnapping: false,
            parallaxOffset: 1.27,
            // onPanelClosed: () {
            //   ref.read(hideMapNavBarProvider.notifier).update((state) => true);
            // },
            onPanelSlide: (position) {
              if (position > 0.65) {
                ref.invalidate(hideMapNavBarProvider);
              } else {
                ref.read(hideMapNavBarProvider.notifier).update((state) => true);
              }
            },
            // onPanelOpened: () {
            //   ref.invalidate(hideMapNavBarProvider);
            // },
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            maxHeight: context.sizeHeight(0.5),
            minHeight: 90,
            backdropEnabled: false,
            backdropOpacity: 0.2,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            panelBuilder: (sc) => ListView(
              controller: sc,
              children: [
                // Divider(
                //   color: Colors.black,
                //   thickness: 1.2,
                //   height: 3.4,
                // ),
                Column(
                  children: List.generate(
                    widget.order.orderItems!.length,
                    (index) {
                      var item = widget.order.orderItems![index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        leading: cachedNetworkImageWidget(
                          imgUrl: item.product?.productImages?.first['image']['url'],
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

                // delivering to widget with client phone number
                riderDeliveringToWidget(context, widget.order.user!),

                //order pick up with address of where item was picked up from
                riderDeliveryRequestListTile(
                  fulfillmentHub: widget.order.fulfillmentHub,
                  context: context,
                  icon: Icons.pedal_bike,
                  title: TextConstant.orderPickUp,
                  bTNText:
                      checkedID!.status == 7 ? TextConstant.pickedUp : TextConstant.iHavePickedUp,
                  subtitle1: ' ${widget.order.fulfillmentHub!.address}',
                  subtitle2: '${pickupLocationDistance.toStringAsFixed(0)}Km away',
                  hasButton: true,
                  isFaded: false,
                  isPickedUp: checkedID!.status! >= 7 ? true : false,
                  onTap: () {
                    if (checkedID!.status != 7) {
                      ref.read(riderAcceptDeclineNotifierProvider.notifier).riderPickUpMethod(
                        onNavigation: () {
                          ref.invalidate(ridersOrderProvider);
                          loadPolyLine();
                        },
                        map: {HiveKeys.orderId.keys: widget.order.id},
                      );
                    }
                  },
                ),

                // delivery addresss
                riderDeliveryRequestListTile(
                  fulfillmentHub: widget.order.fulfillmentHub,
                  context: context,
                  icon: Icons.location_on,
                  title: TextConstant.delivery,
                  bTNText: TextConstant.complete,
                  subtitle1:
                      ' ${widget.order.address!.apartmentNumber} ${widget.order.address!.streetAddress}, ${widget.order.address!.city}, ${widget.order.address?.state} ',
                  subtitle2: '${deliveryLocationDistance.toStringAsFixed(0)}Km away',

                  hasButton: true,
                  isFaded: checkedID!.status! >= 7 ? false : true,
                  isPickedUp: checkedID!.status! > 7 ? true : false,

                  //complete btn
                  onTap: () {
                    if (checkedID!.status == 7) {
                      ref.read(riderAcceptDeclineNotifierProvider.notifier).riderDeliveredMethod(
                        onNavigation: () {
                          ref.invalidate(deliveryRequestsProvider);
                          ref.invalidate(ridersOrderProvider);
                        },
                        map: {HiveKeys.createOrder.keys: widget.order.id},
                      );
                    }
                  },
                ),
              ],
            ),
            body: GoogleMap(
              onMapCreated: (controller) {
                _googleMapController = controller;
              },
              onTap: (argument) {},
              polylines: _polylines,
              markers: {
                Marker(
                    markerId: MarkerId("destination"),
                    position: LatLng(
                      widget.order.address!.metadata?.latitude ?? 0,
                      widget.order.address!.metadata?.longitude ?? 0,
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
              },
              myLocationEnabled: true,
              scrollGesturesEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              // gestureRecognizers: Set()
              //   ..add(Factory<VerticalDragGestureRecognizer>(
              //       () => VerticalDragGestureRecognizer())),
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currentPosition.value?.latitude ?? 0,
                  currentPosition.value?.longitude ?? 0,
                ),
                zoom: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

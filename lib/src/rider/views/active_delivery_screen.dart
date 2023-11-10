// ignore_for_file: prefer_final_fields, must_be_immutable
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tago/app.dart';

class ActiveDeliveryScreen extends ConsumerStatefulWidget {
  const ActiveDeliveryScreen({
    super.key,
    required this.order,
  });
  final OrderListModel order;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ActiveDeliveryScreenState();
}

class _ActiveDeliveryScreenState extends ConsumerState<ActiveDeliveryScreen> {
  late GoogleMapController _googleMapController;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  OrderListModel? checkedID;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  late Socket socket;

  @override
  void initState() {
    super.initState();
    connectToServer();

    Geolocator.getPositionStream().listen((Position? position) async {
      await Future.delayed(const Duration(seconds: 10));
      log("update");
      _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(position!.latitude, position.longitude),
              zoom: 19)));
      setPolyLine();
      socket.emit(
          "updateLocation",
          jsonEncode({
            "riderId": widget.order.riderId,
            "latitude": position.latitude,
            "longitude": position.longitude
          }));
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.order.status == 7) {
        loadPolyLine();
      }
    });
  }

  void connectToServer() {
    try {
      socket = io(baseUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.connect();
      socket.on('connect', (_) => print('connectRider: ${socket.id}'));
    } catch (e) {
      log(e.toString());
    }
  }

  getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(widget.order.address!.metadata!.latitude ?? 0,
          widget.order.address!.metadata!.longitude ?? 0),
      PointLatLng(widget.order.fulfillmentHub!.latitude,
          widget.order.fulfillmentHub!.longitude),
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
        LatLngBounds(
            southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong)),
        20));
  }

  loadPolyLine() {
    getPolyline().then((_) => setPolyLine());
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = ref.watch(getCurrentLocationProvider);
    final isLoading = ref.watch(riderAcceptDeclineNotifierProvider).isLoading;
    final orderList = ref.watch(ridersOrderProvider).valueOrNull;
    checkedID =
        orderList?.where((element) => element.id == widget.order.id).single;

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
                    floating: false,
                    pinned: true,
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
                            onMapCreated: (controller) {
                              _googleMapController = controller;
                            },
                            polylines: _polylines,
                            markers: {
                              Marker(
                                  markerId: MarkerId("destination"),
                                  position: LatLng(
                                    widget.order.address!.metadata?.latitude ??
                                        0,
                                    widget.order.address!.metadata?.longitude ??
                                        0,
                                  ),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueRed)),
                            },
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
                                zoom: 19),
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: List.generate(
                        widget.order.orderItems!.length,
                        (index) {
                          var item = widget.order.orderItems![index];
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
                    child: riderDeliveringToWidget(context, widget.order.user!),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        riderDeliveryRequestListTile(
                          fulfillmentHub: widget.order.fulfillmentHub,
                          context: context,
                          icon: Icons.pedal_bike,
                          title: TextConstant.orderPickUp,
                          bTNText: checkedID!.status == 7
                              ? TextConstant.pickedUp
                              : TextConstant.iHavePickedUp,
                          subtitle1: ' ${widget.order.fulfillmentHub!.address}',
                          subtitle2:
                              '${pickupLocationDistance.toStringAsFixed(0)}Km away',
                          hasButton: true,
                          isFaded: false,
                          isPickedUp: checkedID!.status! >= 7 ? true : false,
                          onTap: () {
                            if (checkedID!.status != 7) {
                              ref
                                  .read(riderAcceptDeclineNotifierProvider
                                      .notifier)
                                  .riderPickUpMethod(
                                onNavigation: () {
                                  ref.invalidate(ridersOrderProvider);
                                  loadPolyLine();
                                },
                                map: {HiveKeys.orderId.keys: widget.order.id},
                              );
                            }
                          },
                        ),

                        //delivery location
                        riderDeliveryRequestListTile(
                          fulfillmentHub: widget.order.fulfillmentHub,
                          context: context,
                          icon: Icons.location_on,
                          title: TextConstant.delivery,
                          bTNText: TextConstant.complete,
                          subtitle1:
                              ' ${widget.order.address!.apartmentNumber} ${widget.order.address!.streetAddress}, ${widget.order.address!.city}, ${widget.order.address?.state} ',
                          subtitle2:
                              '${deliveryLocationDistance.toStringAsFixed(0)}Km away',

                          hasButton: true,
                          isFaded: checkedID!.status! >= 7 ? false : true,
                          isPickedUp: checkedID!.status! > 7 ? true : false,

                          //complete btn
                          onTap: () {
                            if (checkedID!.status == 7) {
                              ref
                                  .read(riderAcceptDeclineNotifierProvider
                                      .notifier)
                                  .riderDeliveredMethod(
                                onNavigation: () {
                                  ref.invalidate(deliveryRequestsProvider);
                                  ref.invalidate(ridersOrderProvider);
                                },
                                map: {
                                  HiveKeys.createOrder.keys: widget.order.id
                                },
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

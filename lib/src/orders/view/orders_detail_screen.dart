// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tago/app.dart';

class OrdersDetailScreen extends ConsumerStatefulWidget {
  const OrdersDetailScreen({
    super.key,
    required this.order,
    this.orderStatusFromOrderScreen,
  });
  final OrderListModel order;
  final int? orderStatusFromOrderScreen;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersDetailScreenState();
}

class _OrdersDetailScreenState extends ConsumerState<OrdersDetailScreen> {
  late GoogleMapController _googleMapController;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  OrderListModel? checkedID;
  late Socket socket;
  LatLng currentLocation = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    connectToServer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.order.status == 7) {
        loadPolyLine();
      }
    });
  }




  void connectToServer() {
    try {
      socket = io(wsBaseUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.connect();

      socket.on('connect', (_) => print('connectUser: ${socket.id}'));
      socket.on('rider${widget.order.rider!.id}LocationUpdate', updateLocation);
    } catch (e) {
      log(e.toString());
    }
  }

  void updateLocation(dynamic data) {
    log(data.toString());
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(data['latitude'], data['longitude']), zoom: 19)));
    setPolyLine();
    currentLocation = LatLng(data['latitude'], data['longitude']);
    // setState(() {});
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
    if (kDebugMode) {
      print("result$result");
    }
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

  bool isFaded({required int status, required OrderStatus orderStatus}) {
    if (orderStatus.status == status || orderStatus.status <= status) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderStatus = ref.watch(orderStatusProvider(widget.order.id.toString())).valueOrNull;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(TextConstant.orderDetails),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: tagoBackButton(
            context: context,
            onTapBack: () {
              pop(context);
              ref.invalidate(orderListProvider);
            },
          ),
        ),
        body: ListView(
          children: [
            Text('${TextConstant.orderID}: ${widget.order.id}'),
            widget.order.status! < 7
                ? Container(
                    height: 142,
                    margin: const EdgeInsets.only(bottom: 15, top: 5),
                    width: context.sizeWidth(1),
                    color: TagoLight.textFieldBorder,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_bike,
                          color: TagoLight.primaryColor,
                        ),
                        Text(TextConstant.awaitingPickup)
                      ],
                    ),
                  )
                : SizedBox(
                    height: context.sizeHeight(0.35),
                    child: GoogleMap(
                      onMapCreated: (controller) {
                        _googleMapController = controller;
                      },
                      mapToolbarEnabled: false,
                      polylines: _polylines,
                      markers: {
                        Marker(
                          markerId: const MarkerId("currentLocation"),
                          position: LatLng(currentLocation.latitude, currentLocation.longitude),
                        ),
                        Marker(
                            markerId: const MarkerId("source"),
                            position: LatLng(
                              widget.order.fulfillmentHub?.latitude ?? 0,
                              widget.order.fulfillmentHub?.longitude ?? 0,
                            ),
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
                        Marker(
                          markerId: const MarkerId("destination"),
                          position: LatLng(
                            widget.order.address!.metadata?.latitude ?? 0,
                            widget.order.address!.metadata?.longitude ?? 0,
                          ),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                        ),
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
                            widget.order.rider!.latitude ?? 0,
                            widget.order.rider!.longitude ?? 0,
                          ),
                          zoom: 19),
                    ),
                  ).padOnly(top: 10, bottom: 10),
            customStepperWidget(
              context: context,
              iconData: Icons.check_circle_outline_sharp,
              title: TextConstant.orderPlaced,
              subtitle: TextConstant.yourOrderWasPlacedSuccessfully,
              isFaded: isFaded(
                orderStatus: OrderStatus.placed,
                status: orderStatus?.status ?? widget.orderStatusFromOrderScreen!,
              ),
            ),
            customStepperWidget(
              context: context,
              iconData: Icons.home_outlined,
              title: TextConstant.orderReceived,
              subtitle: TextConstant.orderReceivedFulfilmentCenter,
              isFaded: isFaded(
                orderStatus: OrderStatus.received,
                status: orderStatus?.status ?? widget.orderStatusFromOrderScreen!,
              ),
            ),
            customStepperWidget(
              context: context,
              iconData: Icons.checklist,
              title: TextConstant.orderConfirmed,
              subtitle: TextConstant.youWillReceiveAnEmail,
              isFaded: isFaded(
                orderStatus: OrderStatus.processing,
                status: orderStatus?.status! ?? widget.orderStatusFromOrderScreen!,
              ),
            ),
            customStepperWidget(
              context: context,
              iconData: Icons.directions_bike,
              title: TextConstant.pickedUp,
              subtitle: TextConstant.itemHasBeenPickedUpCourier,
              isFaded: isFaded(
                orderStatus: OrderStatus.pickedUp,
                status: orderStatus?.status! ?? widget.orderStatusFromOrderScreen!,
              ),
            ),
            customStepperWidget(
              context: context,
              iconData: Icons.drafts_outlined,
              title: TextConstant.delivery,
              subtitle: '30 ${TextConstant.minsLeft}',
              hideDash: true,
              isFaded: isFaded(
                orderStatus: OrderStatus.delivered,
                status: orderStatus?.status! ?? widget.orderStatusFromOrderScreen!,
              ),
            ),
            const Divider(
              thickness: 0.8,
            ),
            Text(
              TextConstant.itemsInYourOrder,
              style: context.theme.textTheme.titleMedium,
            ).padSymmetric(vertical: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.order.orderItems!.length,
              itemBuilder: (context, index) {
                return orderReviewItemsWidget(
                    context: context, item: widget.order.orderItems![index]);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(TextConstant.deliveredTo),
              subtitle: Text(
                '${widget.order.address?.apartmentNumber}, ${widget.order.address?.streetAddress}, ${widget.order.address?.city}, ${widget.order.address?.state}',
              ),
            ),
            // const SizedBox(height: 24),
            // StreamBuilder(
            //   stream: _channel.stream,
            //   builder: (context, snapshot) {
            //     log(snapshot.toString());
            //     return Text(snapshot.hasData ? '${snapshot.data}' : '');
            //   },
            // )
          ],
        ).padAll(20));
  }

  Column orderReviewItemsWidget({
    required BuildContext context,
    required OrderItemModel item,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${item.product!.name}(x${item.quantity})",
          style: context.theme.textTheme.labelMedium?.copyWith(
            fontWeight: AppFontWeight.w400,
          ),
        ),
        Text(
          '${TextConstant.nairaSign} ${item.amount.toString().toCommaPrices()}',
          style: context.theme.textTheme.labelMedium,
        ),
        const Divider(thickness: 1)
      ].columnInPadding(8),
    );
  }
}

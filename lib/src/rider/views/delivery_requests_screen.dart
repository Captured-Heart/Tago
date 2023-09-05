import 'package:tago/app.dart';

class DeliveryRequestScreen extends ConsumerStatefulWidget {
  const DeliveryRequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeliveryRequestScreenState();
}

class _DeliveryRequestScreenState extends ConsumerState<DeliveryRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.deliveryRequests,
        isLeading: true,
        centerTitle: false,
      ),
      body: ListView(children: [
        riderOrdersListTile(
          context: context,
          orderStatus: OrderStatus.delivered,
          isDeliveryRequests: true,
        ),
        riderOrdersListTile(
          context: context,
          orderStatus: OrderStatus.delivered,
          isDeliveryRequests: true,
        )
      ]),
    );
  }
}

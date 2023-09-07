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
    final deliveryRequests = ref.watch(deliveryRequestsProvider);
    return Scaffold(
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
                  (index) => riderOrdersListTile(
                    context: context,
                    orderStatus: OrderStatus.delivered,
                    isDeliveryRequests: true,
                  ),
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
    );
  }
}

import 'package:tago/app.dart';

Widget homeScreenOrderStatusWidget({
  required BuildContext context,
  required WidgetRef ref,
  required OrderListModel orderModel,
}) {
  var orderStatus = orderModel.status ?? 0;
  return Container(
    decoration: const BoxDecoration(
      color: TagoLight.textFieldFilledColor,
      border: Border(bottom: BorderSide(width: 0.1)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                TextConstant.activeOrderstatus,
                style: context.theme.textTheme.bodyLarge,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: getOrderStatusColor(orderStatus).withOpacity(0.1),
              ),
              child: Text(
                getOrderStatusTitle(orderStatus),
                style: context.theme.textTheme.bodyLarge
                    ?.copyWith(color: getOrderStatusColor(orderStatus)),
              ),
            ),
            // Chip(
            //     label: const Text(
            //       TextConstant.pickedup,
            //       style: TextStyle(color: TagoDark.primaryColor),
            //     ),
            //     shape: const ContinuousRectangleBorder(),
            //     backgroundColor: TagoLight.primaryColor.withOpacity(0.1))
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                TextConstant.remainingTime,
                style: context.theme.textTheme.bodyLarge,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: TagoDark.primaryColor,
                ).padOnly(right: 5),
                Text(
                  '12 minutes away',
                  style: context.theme.textTheme.bodyLarge,
                )
              ],
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            // // ignore: invalid_use_of_protected_member
            // ref.read(scaffoldKeyProvider).currentState!.setState(() {
            //   Scaffold.of(context).openDrawer();
            // });

            navBarPush(
              context: context,
              screen: orderModel.status == OrderStatus.delivered.status
                  ? DeliveryCompleteScreen(
                      orderListModel: orderModel,
                    )
                  : OrdersDetailScreen(
                      order: orderModel,
                      orderStatusFromOrderScreen: orderModel.status,
                    ),
              withNavBar: false,
            );
          },
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: const Text(
            TextConstant.viewOrderdetails,
            textAlign: TextAlign.start,
          ),
        )
      ],
    ),
  );
}

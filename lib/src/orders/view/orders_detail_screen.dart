import 'package:flutter_dash/flutter_dash.dart';
import 'package:tago/app.dart';

// 0 - pending
// 1 - placed
// 2 - cancelled
// 4&6  - processing
// 7 -  picked up
// 9 - delivered
class OrdersDetailScreen extends ConsumerWidget {
  final OrderListModel orderListModel;
  final int? orderStatusFromOrderScreen;

  const OrdersDetailScreen({
    super.key,
    required this.orderListModel,
    this.orderStatusFromOrderScreen,
  });

  bool isFaded({required int status, required OrderStatus orderStatus}) {
    if (orderStatus.status == status || orderStatus.status <= status) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountInfo = ref.watch(getAccountInfoProvider);

    final orderStatus = ref
        .watch(orderStatusProvider(orderListModel.id.toString()))
        .valueOrNull;
    log(orderListModel.id!.toString());
// log(orderStatus!.status.toString());
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
            Text('${TextConstant.orderID}: ${orderListModel.id}'),
            Container(
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
            ),
            customStepperWidget(
              context: context,
              iconData: Icons.check_circle_outline_sharp,
              title: TextConstant.orderPlaced,
              subtitle: TextConstant.yourOrderWasPlacedSuccessfully,
              isFaded: isFaded(
                orderStatus: OrderStatus.placed,
                status: orderStatus?.status ?? orderStatusFromOrderScreen!,
              ),
            ),
            customStepperWidget(
              context: context,
              iconData: Icons.home_outlined,
              title: TextConstant.orderReceived,
              subtitle: TextConstant.orderReceivedFulfilmentCenter,
              isFaded: isFaded(
                orderStatus: OrderStatus.received,
                status: orderStatus?.status ?? orderStatusFromOrderScreen!,
              ),
            ),
            customStepperWidget(
              context: context,
              iconData: Icons.checklist,
              title: TextConstant.orderConfirmed,
              subtitle: TextConstant.youWillReceiveAnEmail,
              isFaded: isFaded(
                orderStatus: OrderStatus.processing,
                status: orderStatus?.status! ?? orderStatusFromOrderScreen!,
              ),
            ),
            customStepperWidget(
              context: context,
              iconData: Icons.directions_bike,
              title: TextConstant.pickedUp,
              subtitle: TextConstant.itemHasBeenPickedUpCourier,
              isFaded: isFaded(
                orderStatus: OrderStatus.pickedUp,
                status: orderStatus?.status! ?? orderStatusFromOrderScreen!,
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
                status: orderStatus?.status! ?? orderStatusFromOrderScreen!,
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
              itemCount: orderListModel.orderItems!.length,
              itemBuilder: (context, index) {
                var ordersList = orderListModel.orderItems![index];
                return orderReviewItemsWidget(
                  context: context,
                  orderListModel: ordersList,
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(TextConstant.deliveredTo),
              subtitle: Text(
                accountInfo.valueOrNull?.address?.streetAddress ??
                    TextConstant.noAddressFound,
              ),
            )
          ],
        ).padAll(20));
  }

  Column orderReviewItemsWidget({
    required BuildContext context,
    required dynamic orderListModel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          orderListModel['product']['name'] +
                  ' (x${orderListModel['quantity'].toString()})' ??
              TextConstant.product,
          style: context.theme.textTheme.labelMedium?.copyWith(
            fontWeight: AppFontWeight.w400,
          ),
        ),
        Text(
          '${TextConstant.nairaSign} ${orderListModel['amount'].toString().toCommaPrices()}',
          style: context.theme.textTheme.labelMedium,
        ),
        const Divider(thickness: 1)
      ].columnInPadding(8),
    );
  }

  Row customStepperWidget({
    required BuildContext context,
    required IconData iconData,
    required String title,
    required String subtitle,
    bool? isFaded = false,
    bool hideDash = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              iconData,
              color: isFaded == true
                  ? TagoLight.indicatorActiveColor
                  : TagoLight.primaryColor,
            ),
            !hideDash
                ? const Dash(
                    length: 40,
                    dashLength: 6,
                    direction: Axis.vertical,
                    dashColor: TagoLight.indicatorActiveColor,
                  ).padSymmetric(vertical: 5)
                : const SizedBox.shrink()
          ].columnInPadding(5),
        ),
        Expanded(
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        color: isFaded == true
                            ? TagoLight.indicatorActiveColor
                            : null,
                      ),
                    ),
                    SizedBox(
                      width: context.sizeWidth(0.65),
                      child: Text(
                        subtitle,
                        maxLines: 2,
                        style: context.theme.textTheme.titleSmall?.copyWith(
                          fontWeight: AppFontWeight.w100,
                          color: isFaded == true
                              ? TagoLight.indicatorActiveColor
                              : null,
                        ),
                      ),
                    )
                  ].columnInPadding(5))
              .padOnly(top: 4, left: 10),
        )
      ],
    );
  }
}

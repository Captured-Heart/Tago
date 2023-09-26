import 'package:tago/app.dart';

Container activeOrdersCard({
  required BuildContext context,
  required int orderStatus,
  required OrderListModel orderModel,
}) {
  var product = convertDynamicListToPlaceOrderModel(orderModel.orderItems!);

  getOrderStatusColor(int status) {
    if (status == OrderStatus.cancelled.status) {
      return TagoLight.textError;
    } else if (status == OrderStatus.pending.status) {
      return TagoLight.orange;
    } else {
      return TagoLight.primaryColor;
    }
  }

  getOrderStatusTitle(int status) {
    if (status == OrderStatus.cancelled.status) {
      return OrderStatus.cancelled.message;
    } else if (status == OrderStatus.pending.status) {
      return OrderStatus.pending.message;
    } else if (status == OrderStatus.delivered.status) {
      return OrderStatus.delivered.message;
    } else if (status == OrderStatus.placed.status) {
      return OrderStatus.placed.message;
    } else if (status == OrderStatus.received.status) {
      return OrderStatus.received.message;
    } else if (status == OrderStatus.pickedUp.status) {
      return OrderStatus.pickedUp.message;
    } else if (status == OrderStatus.successful.status) {
      return OrderStatus.successful.message;
    } else {
      return OrderStatus.processing.message;
    }
  }

  return Container(
    // height: 250,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.1),
      ),
    ),
    width: double.infinity,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        cachedNetworkImageWidget(
          imgUrl: product.first.product?.productImages?.first['image']['url'],
          height: 95,
          width: 100,
        ).padOnly(right: 10),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
               TextConstant.nairaSign ,
                  // orderModel.name ?? '',
                  style:
                      context.theme.textTheme.titleMedium?.copyWith(fontWeight: AppFontWeight.w300),
                ).padOnly(bottom: 5),
                Text('${TextConstant.orderID}: ${orderModel.id}',
                    style: context.theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: AppFontWeight.w600)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: getOrderStatusColor(orderStatus).withOpacity(0.1),
                  ),
                  child: Text(
                    // TextConstant.inTransit,
                    getOrderStatusTitle(orderStatus),
                    style: context.theme.textTheme.bodyLarge
                        ?.copyWith(color: getOrderStatusColor(orderStatus)),
                  ),
                ),
              ].columnInPadding(8)),
        ),
      ],
    ),
  );
}

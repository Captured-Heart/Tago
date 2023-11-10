import 'package:tago/app.dart';

Widget riderOrdersListTile({
  required BuildContext context,
  required Enum orderStatus,
  bool? isDeliveryRequests,
  VoidCallback? onAcceptRequest,
  VoidCallback? onViewDetails,
  DeliveryRequestsModel? riderOrderModel,
  List<OrderItemModel>? riderOrder,
}) {
  getOrderStatusColor(Enum status) {
    if (status == OrderStatus.cancelled) {
      return TagoLight.textError;
    } else if (status == OrderStatus.processing) {
      return TagoLight.orange;
    } else {
      return TagoLight.primaryColor;
    }
  }

  getOrderStatusTitle(Enum status) {
    if (status == OrderStatus.cancelled) {
      return TextConstant.cancelled;
    } else if (status == OrderStatus.successful) {
      return TextConstant.successful;
    } else {
      return TextConstant.active;
    }
  }

  var address = riderOrderModel?.order?.address;
  // var riderOrder =
  //     convertDynamicListToRiderOrderItemModel(riderOrderModel!.order!.orderItems ?? []);
  return Container(
    padding: const EdgeInsets.only(bottom: 10, top: 20, left: 10),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.1),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cachedNetworkImageWidget(
          imgUrl: riderOrder?.first.product?.productImages?.first['image']
                  ['url'] ??
              noImagePlaceholderHttp,
          height: 100,
          width: 100,
        ),
        Expanded(
          child: ListTile(
            minLeadingWidth: 80,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            isThreeLine: true,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    riderOrderModel?.order?.name ?? TextConstant.product,
                    style: context.theme.textTheme.bodySmall,
                  ),
                ),
                isDeliveryRequests == true
                    ? const SizedBox.shrink()
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color:
                              getOrderStatusColor(orderStatus).withOpacity(0.1),
                        ),
                        child: Text(
                          getOrderStatusTitle(orderStatus),
                          style: context.theme.textTheme.bodyLarge?.copyWith(
                            color: getOrderStatusColor(orderStatus),
                          ),
                        ),
                      ),
              ].columnInPadding(10),
            ),

            //subtitle
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: context.sizeWidth(0.65),
                    child: Text(
                      '${address?.apartmentNumber}, ${address?.streetAddress}, \n ${address?.city}, ${address?.state}',
                      style: context.theme.textTheme.bodyMedium,
                    ),
                  ).padSymmetric(vertical: 5),

                  // IS DELIVERY REQUESTS == TRUE
                  isDeliveryRequests == true
                      ? Row(
                          children: [
                          Expanded(
                            child: riderOrderModel!.status! > 0
                                ? Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: riderOrderModel.status == 1 ||
                                              riderOrderModel.status == 4
                                          ? TagoLight.primaryColor
                                              .withOpacity(0.1)
                                          : TagoLight.textError
                                              .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Text(
                                      riderOrderModel.status == 1 ||
                                              riderOrderModel.status == 4
                                          ? TextConstant.accepted
                                          : TextConstant.declined,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.listTileTitleLight
                                          .copyWith(
                                        color: riderOrderModel.status == 1 ||
                                                riderOrderModel.status == 4
                                            ? TagoLight.primaryColor
                                            : TagoLight.textError,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: onAcceptRequest,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: TagoLight.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Text(
                                        TextConstant.acceptRequest,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.listTileTitleLight
                                            .copyWith(
                                          color:
                                              TagoLight.scaffoldBackgroundColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: onViewDetails,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                decoration: BoxDecoration(
                                  color: TagoLight.orange.withOpacity(0.1),
                                ),
                                child: Text(
                                  TextConstant.viewdetails,
                                  textAlign: TextAlign.center,
                                  style: context.theme.textTheme.bodyLarge
                                      ?.copyWith(
                                    color: TagoLight.orange,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ].rowInPadding(8))
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: TagoLight.orange.withOpacity(0.1),
                          ),
                          child: Text(
                            TextConstant.viewdetails,
                            style: context.theme.textTheme.bodyLarge?.copyWith(
                              color: TagoLight.orange,
                            ),
                          ),
                        ),
                  // .debugBorder()
                ].columnInPadding(8)),
          ),
        ),
      ],
    ),
  );
}

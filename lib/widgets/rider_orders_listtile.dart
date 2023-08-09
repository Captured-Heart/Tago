import 'package:tago/app.dart';

Widget riderOrdersListTile({
  required BuildContext context,
  required Enum orderStatus,
  bool? isDeliveryRequests,
  VoidCallback? onAcceptRequest,
  VoidCallback? onViewDetails,
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

  return Container(
    padding: const EdgeInsets.only(bottom: 10, top: 20),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.1),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          drinkImages[3],
          height: 100,
          width: 100,
          fit: BoxFit.fill,
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
                Text(
                  'Fanta Drink - 50cl Pet x 12',
                  style: context.theme.textTheme.bodySmall,
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
                    width: context.sizeWidth(0.36),
                    child: Text(
                      '12 Adesemoye Avenue, Ikeja, Lagos  .   2km',
                      style: context.theme.textTheme.bodyMedium,
                    ),
                  ).padSymmetric(vertical: 5),

                  // IS DELIVERY REQUESTS == TRUE
                  isDeliveryRequests == true
                      ? Row(
                          children: [
                          GestureDetector(
                            onTap: onAcceptRequest,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: TagoLight.primaryColor,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Text(
                                TextConstant.acceptRequest,
                                style: AppTextStyle.listTileTitleLight.copyWith(
                                  color: TagoLight.scaffoldBackgroundColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onViewDetails,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                color: TagoLight.orange.withOpacity(0.1),
                              ),
                              child: Text(
                                TextConstant.viewdetails,
                                style:
                                    context.theme.textTheme.bodyLarge?.copyWith(
                                  color: TagoLight.orange,
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

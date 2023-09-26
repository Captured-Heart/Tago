import 'package:tago/app.dart';

Widget riderDeliveringToWidget(
  BuildContext context,
  OrderModel orders,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        TextConstant.deliveringTo,
        textAlign: TextAlign.left,
        style: context.theme.textTheme.bodyLarge,
      ),
      ListTile(
        // dense: true,
        contentPadding: EdgeInsets.zero,
        title: Text(
          '${orders.user?.fname} ${orders.user?.lname}',
          textAlign: TextAlign.left,
        ),
        subtitle: Text(orders.user?.phoneNumber ?? ''),
        trailing: IconButton(
          onPressed: () {
            UrlLaunchOptions().makePhoneCall(orders.user!.phoneNumber!);
          },
          icon: const Icon(
            Icons.phone,
            color: TagoLight.primaryColor,
          ),
        ),
      ),
    ],
  ).padSymmetric(horizontal: 20, vertical: 10);
}

Widget riderDeliveryRequestListTile({
  required FulfillmentHubModel? fulfillmentHub,
  required BuildContext context,
  required IconData icon,
  required String title,
  required String subtitle1,
  required String subtitle2,
  String? bTNText,
  bool? isFaded = false,
  bool hideDash = false,
  bool hasButton = false,
  bool isPickedUp = false,
  VoidCallback? onTap,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(
            icon,
            color: isFaded == true ? TagoLight.indicatorActiveColor : TagoLight.primaryColor,
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
                      color: isFaded == true ? TagoLight.indicatorActiveColor : null,
                    ),
                  ),
                  Text(
                    subtitle1,
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      color: isFaded == true ? TagoLight.indicatorActiveColor : null,
                    ),
                  ).padOnly(top: 8),
                  Text(
                    subtitle2,
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      color: isFaded == true ? TagoLight.indicatorActiveColor : null,
                    ),
                  ),
                  hasButton == false
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          onTap: onTap,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: isFaded == true
                                    ? TagoLight.indicatorInactiveColor
                                    : isPickedUp == true
                                        ? TagoLight.primaryColor.withOpacity(0.1)
                                        : TagoLight.primaryColor,
                                borderRadius: BorderRadius.circular(7)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                isPickedUp == true
                                    ? const Icon(
                                        Icons.check,
                                        color: TagoLight.primaryColor,
                                        size: 16,
                                      ).padOnly(right: 3)
                                    : const SizedBox.shrink(),
                                Text(
                                  bTNText ?? '',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.listTileTitleLight.copyWith(
                                    color: isPickedUp == true
                                        ? TagoLight.primaryColor
                                        : TagoLight.scaffoldBackgroundColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ].columnInPadding(5))
            .padOnly(top: 4, left: 10),
      )
    ],
  );
}

import 'package:tago/app.dart';

Column checkOutReviewItemsWidget({
  required BuildContext context,
  required PlaceOrderModel placeOrderModel,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '${placeOrderModel.product!.label!.toTitleCase()} (x${placeOrderModel.quantity})',
        // 'Coca-cola drink - pack of 6 can',
        style: context.theme.textTheme.labelMedium?.copyWith(
          fontWeight: AppFontWeight.w400,
        ),
      ),
      // const Divider(thickness: 1),
      // Text(
      //   'Coca-cola drink - pack of 6 can',
      //   style: context.theme.textTheme.labelMedium?.copyWith(
      //     fontWeight: AppFontWeight.w400,
      //   ),
      // ),
      Text(
        '${TextConstant.nairaSign} ${placeOrderModel.product?.amount.toString().toCommaPrices() ?? '0'}',
        style: context.theme.textTheme.labelMedium,
      ),
      const Divider(thickness: 1)
    ].columnInPadding(8),
  );
}

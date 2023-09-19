import 'package:tago/app.dart';

Column checkOutReviewItemsWidget({
  required BuildContext context,
  required CartModel cartModel,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     
      Text(
        cartModel.product?.label?.toTitleCase() ?? TextConstant.product,
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
        '${TextConstant.nairaSign} ${cartModel.product?.amount.toString().toCommaPrices() ?? '0'}',
        style: context.theme.textTheme.labelMedium,
      ),
      const Divider(thickness: 1)
    ].columnInPadding(8),
  );
}

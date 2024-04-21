import 'package:tago/app.dart';

Column singleProductListTileWidget({
  required BuildContext context,
  required AsyncValue<ProductsModel>? products,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      //title
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
            products?.valueOrNull?.label?.toTitleCase() ?? '',
            style: context.theme.textTheme.labelMedium,
          ).padOnly(right: 15)),
          Container(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: TagoDark.orange,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'save ${products?.valueOrNull?.savedPerc ?? 0}%',
              style: context.theme.textTheme.labelLarge?.copyWith(
                fontSize: 12,
              ),
            ),
          )
        ],
      ),

      //subtitle
      Text(
        TextConstant.nairaSign +
            double.parse(products?.valueOrNull?.amount.toString() ?? '0')
                .toString()
                .toCommaPrices(),
        style: context.theme.textTheme.titleMedium,
      ).padOnly(left: 10),

      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.star,
            color: TagoDark.orange,
          ).padOnly(right: 6),
          const Text('3.5')
        ],
      )
    ].columnInPadding(5),
  );
}

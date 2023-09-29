import 'package:tago/app.dart';

Widget singleProductListTileWidget({
  required BuildContext context,
  required AsyncValue<ProductsModel>? products,
}) {
  return products!.isLoading
      ? shimmerWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.sizeWidth(0.5),
                        child: const LinearProgressIndicator(
                          value: 0.65,
                          minHeight: 10,
                        ).padOnly(bottom: 5),
                      ),
                      SizedBox(
                        width: context.sizeWidth(0.3),
                        child: const LinearProgressIndicator(
                          value: 0.3,
                          minHeight: 10,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      color: TagoDark.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: context.sizeWidth(0.2),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.3,
                        minHeight: 10,
                      ),
                    ),
                  ],
                ),
              )
            ].columnInPadding(5),
          ),
        )
      : Column(
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
                  products.valueOrNull?.label?.toTitleCase() ?? '',
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
                    'save ${products.valueOrNull?.savedPerc?.toStringAsFixed(1) ?? 0}%',
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
                  double.parse(products.valueOrNull?.amount.toString() ?? '0')
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
                Text(
                  '${(getAverageOfRatings(listOfDoubles: products.value?.productReview?.map((e) => e['rating']).toList()) ?? 0.0)} ',
                )
              ],
            ),
          ].columnInPadding(5),
        );
}

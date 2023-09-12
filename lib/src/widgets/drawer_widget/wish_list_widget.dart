import 'package:tago/app.dart';

Widget wishlistWidget({
  required BuildContext context,
  bool? isInCartAlready,
  required VoidCallback onAddToCart,
  required VoidCallback deleteFromCart,
  required ProductsModel productsModel,
}) {
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
        cachedNetworkImageWidget(
          imgUrl: productsModel.productImages?.first['image']['url'],
          height: 100,
        ),
        Expanded(
          child: ListTile(
            minLeadingWidth: 80,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            isThreeLine: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productsModel.name ?? '',
                  // 'Fanta Drink - 50cl Pet x 12',
                  style: context.theme.textTheme.bodySmall,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    productsModel.savedPerc != null
                        ? Text(
                            productsModel.amount.toString().toCommaPrices(),
                            style: context.theme.textTheme.bodyMedium?.copyWith(
                                decoration: TextDecoration.lineThrough),
                          )
                        : const SizedBox.shrink(),
                    Text(
                      productsModel.originalAmount == null
                          ? productsModel.amount.toString().toCommaPrices()
                          : productsModel.originalAmount
                              .toString()
                              .toCommaPrices(),
                      style: context.theme.textTheme.titleMedium,
                    ),
                  ].rowInPadding(5),
                ),
              ].columnInPadding(10),
            ),

            //subtitle
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isInCartAlready != true
                    ? ElevatedButton(
                        onPressed: onAddToCart,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(25),
                          visualDensity: VisualDensity.compact,
                        ),
                        child: Text(
                          TextConstant.addtocart,
                          style: context.theme.textTheme.bodyLarge?.copyWith(
                            color: TagoDark.scaffoldBackgroundColor,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: deleteFromCart,
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: const Size.fromHeight(25),
                            visualDensity: VisualDensity.compact,
                            foregroundColor: TagoLight.primaryColor,
                            backgroundColor:
                                TagoLight.textError.withOpacity(0.15)),
                        child: Text(
                          TextConstant.deleteFromcart,
                          style: context.theme.textTheme.bodyLarge?.copyWith(
                            color: TagoDark.textError.withOpacity(0.6),
                          ),
                        ),
                      )
                // .debugBorder()
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

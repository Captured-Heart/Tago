import 'package:tago/app.dart';

Widget wishlistWidget({
  required BuildContext context,
  bool? isInCartAlready,
  required VoidCallback onAddToCart,
  required ProductsModel productsModel,
}) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10, top: 20),
    width: context.sizeWidth(0.9),
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
          width: 100,
        ),
        Expanded(
          child: ListTile(
            // minLeadingWidth: 80,
            visualDensity: VisualDensity.compact,
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
                            TextConstant.nairaSign +
                                productsModel.amount.toString().toCommaPrices(),
                            style: context.theme.textTheme.bodyMedium
                                ?.copyWith(decoration: TextDecoration.lineThrough),
                          )
                        : const SizedBox.shrink(),
                    Expanded(
                      child: Text(
                        productsModel.originalAmount == null
                            ? TextConstant.nairaSign +
                                productsModel.amount.toString().toCommaPrices()
                            : TextConstant.nairaSign +
                                productsModel.originalAmount.toString().toCommaPrices(),
                        style: context.theme.textTheme.titleMedium,
                      ),
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
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 11),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: TagoLight.primaryColor.withOpacity(0.2),
                        ),
                        child: Text(
                          TextConstant.addedTocart,
                          style: context.theme.textTheme.bodyLarge?.copyWith(
                            color: TagoDark.primaryColor,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

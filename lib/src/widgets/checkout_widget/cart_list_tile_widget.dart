import 'package:tago/app.dart';

Widget myCartListTile({
  required BuildContext context,
  required CartModel cartModel,
  required int? quantity,
  required ProductsModel? product,
  required VoidCallback onDeleteFN,
  required VoidCallback onAddFN,
}) {
  return Container(
    width: context.sizeWidth(0.9),
    padding: const EdgeInsets.only(bottom: 10, top: 20, left: 10),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.1),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        cachedNetworkImageWidget(
          imgUrl: cartModel.product?.productImages?.first['image']['url'],
          height: 100,
          width: 100,
        ),
        Expanded(
          child: ListTile(
            minLeadingWidth: 80,
            // contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            isThreeLine: true,

            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartModel.product!.name!,
                  // 'Fanta Drink - 50cl Pet x 12 Fanta Drink Fanta Drink',
                  style: context.theme.textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  TextConstant.nairaSign +
                      // updatePrice()
                      (cartModel.product!.amount!).toString().toCommaPrices(),
                  // 'N1,879',
                  style: context.theme.textTheme.titleMedium,
                ),
              ].columnInPadding(10),
            ),

            //subtitle
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // minus and delete button
                    addMinusBTN(
                      context: context,
                      isMinus: true,
                      onTap: onDeleteFN,
                    ),
                    Text(
                      cartModel.quantity.toString(),
                      style: context.theme.textTheme.titleLarge,
                    ),

                    //add button
                    addMinusBTN(
                      context: context,
                      isMinus: false,
                      onTap: onAddFN,
                    ),
                  ].rowInPadding(15),
                ),
                // showError == false
                quantity! < product!.availableQuantity!
                    ? const SizedBox.shrink()
                    : Text(
                        'The available quantity of ${cartModel.product!.name} is (${product.availableQuantity})',
                        style: context.theme.textTheme.labelSmall,
                      ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

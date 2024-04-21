import 'package:tago/app.dart';

Widget getFreeDeliveryDesign(List<int> indexList, int index, BuildContext context) {
  if (indexList.contains(index)) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: const BoxDecoration(
            color: TagoLight.orange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
            )),
        child: Text(
          'Free delivery',
          style: context.theme.textTheme.labelMedium?.copyWith(
              color: TagoLight.scaffoldBackgroundColor, fontFamily: TextConstant.fontFamilyBold),
        ).padAll(5),
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}

class FruitsAndVeggiesCard extends StatelessWidget {
  const FruitsAndVeggiesCard({
    super.key,
    required this.addToCartBTN,
    required this.index,
    required this.productModel,
    this.indexList,
    this.isFreeDelivery,
    this.productImagesList,
  });
  // required int index,
  // required BuildContext context,
  // bool? isFreeDelivery,
  // List<int>? indexList,
  // List<dynamic>? productImagesList,
  // required ProductsModel productModel,
  // required VoidCallback addToCartBTN,
  final int index;
  final bool? isFreeDelivery;
  final List<int>? indexList;
  final List<dynamic>? productImagesList;
  final ProductsModel productModel;
  final VoidCallback addToCartBTN;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Card(
            elevation: 0.3,
            child: Stack(
              children: [
                cachedNetworkImageWidget(
                  imgUrl: productImagesList!.first['image']['url'],
                  height: 140,
                ),
                getFreeDeliveryDesign(
                  indexList ?? [],
                  index,
                  context,
                ),
                Positioned(
                  // alignment: Alignment.bottomRight,
                  bottom: 10,
                  right: -1,
                  child: AddMinusBTN(
                    onTap: addToCartBTN,
                    isMinus: false,
                  ),
                )
              ],
            ),
          ),
        ),
        Text(
          productModel.name ?? '',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: context.theme.textTheme.labelMedium?.copyWith(
            fontSize: 12,
            fontWeight: AppFontWeight.w400,
            fontFamily: TextConstant.fontFamilyNormal,
          ),
        ).padSymmetric(vertical: 8),
        Text(
          'N${productModel.amount}',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontFamily: TextConstant.fontFamilyNormal,
            fontSize: 12,
          ),
          textAlign: TextAlign.start,
        )
      ],
    );
  }
}
// Column fruitsAndVeggiesCard({
//   required int index,
//   required BuildContext context,
//   bool? isFreeDelivery,
//   List<int>? indexList,
//   List<dynamic>? productImagesList,
//   required ProductsModel productModel,
//   required VoidCallback addToCartBTN,
// }) {
//   // var products = convertDynamicListToProductListModel(productImagesList!);
//   return
// }

// Widget addMinusBTN({
//   bool? isMinus,
//   required BuildContext context,
//   required VoidCallback onTap,
// }) {
//   return ElevatedButton(
//     onPressed: onTap,
//     style: ElevatedButton.styleFrom(
//       shape: const CircleBorder(),
//       elevation: 0,
//       shadowColor: Colors.transparent,
//       visualDensity: VisualDensity.compact,
//       maximumSize: const Size.fromRadius(15),
//       minimumSize: const Size.fromRadius(5),
//       padding: EdgeInsets.zero,
//       backgroundColor:
//           isMinus == true ? TagoLight.primaryColor.withOpacity(0.15) : TagoLight.primaryColor,
//     ),
//     child: Icon(
//       isMinus == true ? Icons.remove : Icons.add,
//       color: isMinus == true ? TagoDark.primaryColor : TagoDark.scaffoldBackgroundColor,
//       size: 20,
//     ),
//   );
// }

class AddMinusBTN extends StatelessWidget {
  const AddMinusBTN({
    super.key,
    required this.onTap,
    this.isMinus,
  });
  final bool? isMinus;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        elevation: 0,
        shadowColor: Colors.transparent,
        visualDensity: VisualDensity.compact,
        maximumSize: const Size.fromRadius(15),
        minimumSize: const Size.fromRadius(5),
        padding: EdgeInsets.zero,
        backgroundColor:
            isMinus == true ? TagoLight.primaryColor.withOpacity(0.15) : TagoLight.primaryColor,
      ),
      child: Icon(
        isMinus == true ? Icons.remove : Icons.add,
        color: isMinus == true ? TagoDark.primaryColor : TagoDark.scaffoldBackgroundColor,
        size: 20,
      ),
    );
  }
}

Widget fruitsAndVeggiesCardLoader({
  required BuildContext context,
}) {
  return shimmerWidget(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Fruit and Vegetable",
          style: context.theme.textTheme.titleLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: 0.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            4,
            (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              width: 180,
              height: 80,
              padding: const EdgeInsets.all(8),
            ),
          ),
        ),
      ],
    ).padOnly(bottom: 35),
  );
}

Widget tagScreenCardLoader({
  required BuildContext context,
}) {
  return shimmerWidget(
      child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: 0.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              4,
              (index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    width: 180,
                    height: 50,
                  ))));
}

// Widget productCard({
//   required BuildContext context,
//   required ProductsModel productModel,
//   required WidgetRef ref,
//   required int quantity,
// }) {
//   return GestureDetector(
//     // key: UniqueKey(),
//     onTap: () {
//       addRecentlyViewedToStorage(productModel);

//       navBarPush(
//         context: context,
//         screen: SingleProductPage(
//           id: productModel.id ?? 0,
//           productsModel: productModel,
//         ),
//         withNavBar: false,
//       );
//     },
//     child: Container(
//       // key: UniqueKey(),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: Colors.white,
//       ),
//       width: 180,
//       padding: const EdgeInsets.all(8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           cachedNetworkImageWidget(
//             imgUrl: productModel.productImages!.first['image']['url'],
//             height: 140,
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             productModel.name ?? '',
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: context.theme.textTheme.labelMedium?.copyWith(
//               fontSize: 14,
//               fontWeight: AppFontWeight.w500,
//               fontFamily: TextConstant.fontFamilyNormal,
//             ),
//           ),
//           Expanded(
//             child: Container(),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   '${TextConstant.nairaSign} ${productModel.amount}',
//                   style: context.theme.textTheme.titleLarge?.copyWith(
//                     fontFamily: TextConstant.fontFamilyNormal,
//                     fontSize: 16,
//                   ),
//                   textAlign: TextAlign.start,
//                 ),
//               ),
//               checkCartBoxLength()?.map((e) => e.product?.id).toList().contains(productModel.id) ==
//                       true
//                   ? Container(
//                       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
//                       margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
//                       decoration: BoxDecoration(
//                           color: TagoLight.primaryColor.withOpacity(0.13),
//                           borderRadius: BorderRadius.circular(20)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           //decrease
//                           GestureDetector(
//                             // onTap: onDecrementBTN,
//                             onTap: () {
//                               log('(Home screen) Decrement tapped');

//                               if (quantity > 1) {
//                                 //! REDUCE THE QUANTITY

//                                 incrementDecrementCartValueMethod(
//                                   cartIndexFromID(productModel)!,
//                                   CartModel(quantity: quantity - 1, product: productModel),
//                                 );
//                                 // setState();
//                               } else {
//                                 //! delete from the cart locally
//                                 deleteCartFromListMethod(
//                                   index: cartIndexFromID(productModel)!,
//                                   cartModel: CartModel(),
//                                   context: context,
//                                   setState: () {},
//                                   isProductModel: true,
//                                   productsModel: productModel,
//                                 );
//                                 // setState(() {});
//                                 //! DELETE FROM THE CART IN BACKEND
//                                 ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
//                                   map: {
//                                     ProductTypeEnums.productId.name: productModel.id.toString(),
//                                   },
//                                 ).whenComplete(
//                                   () => ref.invalidate(getCartListProvider(false)),
//                                 );
//                               }
//                             },
//                             child: const Icon(
//                               Icons.remove,
//                               size: 22,
//                               color: TagoLight.primaryColor,
//                             ),
//                           ),
//                           Text(
//                             '${cartQuantityFromName(productModel) ?? 1}',
//                             style: context.theme.textTheme.titleMedium,
//                           ),

//                           //increase
//                           GestureDetector(
//                             // onTap: onIncrementBTN,
//                             onTap: () {
//                               log('(Home screen) Increment tapped');

//                               if (quantity < productModel.availableQuantity!) {
//                                 // log('increased: ${cartIndexFromID(productModel)!} ');
//                                 incrementDecrementCartValueMethod(
//                                   cartIndexFromID(productModel)!,
//                                   CartModel(quantity: quantity + 1, product: productModel),
//                                 );
//                               } else {
//                                 showScaffoldSnackBarMessage(
//                                   'The available quantity of ${productModel.name} is (${productModel.availableQuantity})',
//                                   isError: true,
//                                   duration: 2,
//                                 );
//                               }
//                             },
//                             child: const Icon(
//                               Icons.add,
//                               size: 22,
//                               color: TagoLight.primaryColor,
//                             ),
//                           ),
//                         ].rowInPadding(7),
//                       ),
//                     )
//                   : Container(
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7.0),
//                           border: Border.all(color: TagoDark.primaryColor)),
//                       child: GestureDetector(
//                         // onTap: addToCartBTN,
//                         onTap: () {
//                           if (productModel.availableQuantity! < 1) {
//                             //product is out of stock
//                             showScaffoldSnackBarMessage(
//                               TextConstant.productIsOutOfStock,
//                               isError: true,
//                             );
//                           } else {
//                             //add to cart (LOCALLY)
//                             saveToCartLocalStorageMethod(
//                               CartModel(quantity: 1, product: productModel),
//                             );
//                             // add to cart (BACKEND)
//                             ref.read(cartNotifierProvider.notifier).addToCartMethod(
//                               map: {
//                                 ProductTypeEnums.productId.name: productModel.id.toString(),
//                                 ProductTypeEnums.quantity.name: '1',
//                               },
//                             );
//                             ref.invalidate(getCartListProvider(false));
//                           }
//                         },
//                         child: Text(
//                           'Add',
//                           style: context.theme.textTheme.titleMedium?.copyWith(
//                               fontFamily: TextConstant.fontFamilyNormal,
//                               fontSize: 12,
//                               color: TagoDark.orange),
//                         ),
//                       ),
//                     )
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }

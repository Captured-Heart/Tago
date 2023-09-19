import 'package:tago/app.dart';

class MyCartListTileWidget extends ConsumerStatefulWidget {
  const MyCartListTileWidget({
    super.key,
    required this.cartModel,
    required this.cartModelList,
    required this.onDelete,
    required this.onTap,
    required this.subtitleWidget,
  });
  final CartModel cartModel;
  final List<CartModel> cartModelList;

  final VoidCallback onDelete;
  final VoidCallback? onTap;
  final Widget subtitleWidget;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCartListTileWidgetState();
}

class _MyCartListTileWidgetState extends ConsumerState<MyCartListTileWidget> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> cartItemsNotifier = ValueNotifier<int>(widget.cartModel.quantity!);
    // var totalAmount = widget.cartModelList
    //     .map((e) => e.product!.amount)
    //     .fold(0, (previousValue, element) => previousValue + element!);
    // log('total Amount: $totalAmount');
    return ValueListenableBuilder(
        valueListenable: cartItemsNotifier,
        builder: (context, value, _) {
          return GestureDetector(
            onTap: widget.onTap,
            child: Container(
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
                    imgUrl: widget.cartModel.product?.productImages?.last['image']['url'],
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
                            widget.cartModel.product!.name!,
                            // 'Fanta Drink - 50cl Pet x 12 Fanta Drink Fanta Drink',
                            style: context.theme.textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            TextConstant.nairaSign +
                                (widget.cartModel.product!.amount! * value)
                                    .toString()
                                    .toCommaPrices(),
                            // 'N1,879',
                            style: context.theme.textTheme.titleMedium,
                          ),
                        ].columnInPadding(10),
                      ),

                      //subtitle
                      subtitle: widget.subtitleWidget,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

// Widget myCartListTile(
//     {required BuildContext context,
//     required WidgetRef ref,
//     required CartModel cartModel,
//     required VoidCallback onDelete,
//     VoidCallback? onTap,
//     Key? key}) {
//   ValueNotifier<int> cartItemsNotifier = ValueNotifier<int>(cartModel.quantity!);

//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       key: key,
//       width: context.sizeWidth(0.9),
//       padding: const EdgeInsets.only(bottom: 10, top: 20, left: 10),
//       decoration: const BoxDecoration(
//         border: Border(
//           bottom: BorderSide(width: 0.1),
//         ),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           cachedNetworkImageWidget(
//             imgUrl: cartModel.product?.productImages?.last['image']['url'],
//             height: 100,
//             width: 100,
//           ),
//           Expanded(
//             child: ListTile(
//               minLeadingWidth: 80,
//               // contentPadding: EdgeInsets.zero,
//               visualDensity: VisualDensity.adaptivePlatformDensity,
//               isThreeLine: true,

//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     cartModel.product!.name!,
//                     // 'Fanta Drink - 50cl Pet x 12 Fanta Drink Fanta Drink',
//                     style: context.theme.textTheme.bodySmall,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     TextConstant.nairaSign +
//                         (cartModel.product!.amount! * cartItemsNotifier.value)
//                             .toString()
//                             .toCommaPrices(),
//                     // 'N1,879',
//                     style: context.theme.textTheme.titleMedium,
//                   ),
//                 ].columnInPadding(10),
//               ),

//               //subtitle
//               subtitle: ValueListenableBuilder(
//                 valueListenable: cartItemsNotifier,
//                 builder: (context, value, child) {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       addMinusBTN(
//                         context: context,
//                         isMinus: true,
//                         isDelete: value < 2 ? true : false,
//                         onTap: () {
//                           log(cartModel.product?.name ?? '');
//                           if (value > 1) {
//                             log(cartModel.product?.name ?? '');

//                             cartItemsNotifier.value--;
//                           } else {
//                             onDelete();
//                           }
//                         },
//                       ),
//                       Text(
//                         value.toString(),
//                         style: context.theme.textTheme.titleLarge,
//                       ),
//                       addMinusBTN(
//                         context: context,
//                         isMinus: false,
//                         onTap: () {
//                           cartItemsNotifier.value++;
//                         },
//                       ),
//                     ].rowInPadding(15),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

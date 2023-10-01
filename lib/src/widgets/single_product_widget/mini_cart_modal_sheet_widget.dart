import 'package:tago/app.dart';

class SingleProductMiniCartModalWidget extends ConsumerStatefulWidget {
  const SingleProductMiniCartModalWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SingleProductMiniCartModalWidgetState();
}

class _SingleProductMiniCartModalWidgetState
    extends ConsumerState<SingleProductMiniCartModalWidget> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(getCartListProvider(true));

    int calculateTotalPrice() {
      int total = 0;
      for (var item in cartList.valueOrNull!) {
        total += item.quantity! * item.product!.amount!;
      }
      return total;
    }

    return Consumer(
      builder: (context, ref, _) {
        final cartList = ref.watch(getCartListProvider(true));

        return FullScreenLoader(
          isLoading: ref.watch(cartNotifierProvider).isLoading,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: cartList
                .when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  pop(context);
                                },
                                child: const Icon(Icons.close),
                              ),
                            ).padOnly(right: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.cartArrowDown,
                                  size: 44,
                                  color: TagoLight.textHint,
                                ),
                                Text(
                                  TextConstant.cartIsEmpty,
                                  style: context.theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: AppFontWeight.w100,
                                    fontFamily: TextConstant.fontFamilyLight,
                                  ),
                                )
                              ].columnInPadding(20),
                            ).padSymmetric(vertical: 30)
                          ]);
                    }
                    return ListView(
                      shrinkWrap: true,
                      controller: controller,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(TextConstant.myCart),
                              GestureDetector(
                                onTap: () {
                                  pop(context);
                                },
                                child: const Icon(Icons.close),
                              )
                            ],
                          ),
                          subtitle: Text(
                            '${TextConstant.items} (${data.length})',
                            style: context.theme.textTheme.bodyLarge,
                          ),
                        ),

                        ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          controller: controller,
                          itemBuilder: (context, index) {
                            var cartModel = data[index];
                            var quantity = data[index].quantity;
                            var product = data[index].product;

                            return myCartListTile(
                              context: context,
                              cartModel: cartModel,
                              quantity: quantity,
                              data: data,
                              index: index,
                              product: product,
                              onDeleteFN: () {
                                if (quantity! > 1) {
                                  setState(() {
                                    data[index] = cartModel.copyWith(
                                      quantity: quantity - 1,
                                      // product: product?.copyWith(amount: decreasePrice()),
                                    );
                                  });
                                } else {
                                  // delete from cart
                                  ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
                                    map: {
                                      ProductTypeEnums.productId.name:
                                          cartModel.product!.id.toString(),
                                    },
                                  ).whenComplete(
                                    () => ref.invalidate(getCartListProvider),
                                  );
                                }
                              },
                              onAddFN: () {
                                if (quantity! < product!.availableQuantity!) {
                                  setState(() {
                                    data[index] = cartModel.copyWith(
                                      quantity: quantity + 1,
                                      // product: product?.copyWith(
                                      //   amount: updatePrice(),
                                      // ),
                                    );
                                  });
                                }
                              },
                            );

                            // MyCartListTileWidget(
                            //   cartModel: cartModel,
                            //   cartModelList: data,
                            //   onDelete: () {
                            //     ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
                            //       map: {
                            //         ProductTypeEnums.productId.name: cartModel.product!.id.toString(),
                            //       },
                            //     ).whenComplete(
                            //       () => ref.invalidate(getCartListProvider),
                            //     );
                            //   },
                            //   subtitleWidget: SizedBox(),
                            // );
                          },
                        ),

                        //
                        Column(
                          children: [
                            SizedBox(
                              width: context.sizeWidth(1),
                              child: ElevatedButton(
                                onPressed: () {
                                  pop(context);

                                  push(
                                    context,
                                    CheckoutScreen(
                                      cartModel: data,
                                      totalAmount: int.tryParse(calculateTotalPrice().toString()),
                                      placeOrderModel: List.generate(
                                        data.length,
                                        (index) {
                                          return PlaceOrderModel(
                                            amount: data[index].product!.amount,
                                            quantity: data[index].quantity,
                                            productId: '${data[index].product?.id}',
                                            product: data[index].product,
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                    '${TextConstant.checkout} ( ${TextConstant.nairaSign}${calculateTotalPrice().toString().toCommaPrices()} )'),
                              ),
                            ).padOnly(top: 30),
                            TextButton(
                              onPressed: () {
                                pop(context);
                                pop(context);
                              },
                              child: const Text(TextConstant.continueShopping),
                            )
                          ],
                        ).padOnly(top: 10)
                      ],
                    );
                  },
                  error: (error, _) => Center(
                    child: Text(error.toString()),
                  ),
                  loading: () => SizedBox(
                    height: context.sizeHeight(0.4),
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                )
                .padSymmetric(horizontal: 10, vertical: 5),
          ),
        );
      },
    );
  }
}



// Consumer singleProductMiniCartModalWidget() {
//   ScrollController controller = ScrollController();

//   return Consumer(
//     builder: (context, ref, _) {
//       final cartList = ref.watch(getCartListProvider(true));

//       return FullScreenLoader(
//         isLoading: ref.watch(cartNotifierProvider).isLoading,
//         child: Container(
//           margin: const EdgeInsets.only(top: 20),
//           child: cartList
//               .when(
//                 data: (data) {
//                   var prices = data
//                       .map((e) => e.product?.amount)
//                       .fold(0, (previousValue, element) => previousValue + element!)
//                       .toString();

//                   return ListView(
//                     shrinkWrap: true,
//                     controller: controller,
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     // mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ListTile(
//                         title: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(TextConstant.myCart),
//                             GestureDetector(
//                               onTap: () {
//                                 pop(context);
//                               },
//                               child: const Icon(Icons.close),
//                             )
//                           ],
//                         ),
//                         subtitle: Text(
//                           '${TextConstant.items} (${data.length})',
//                           style: context.theme.textTheme.bodyLarge,
//                         ),
//                       ),

//                       ListView.builder(
//                         itemCount: data.length,
//                         shrinkWrap: true,
//                         controller: controller,
//                         itemBuilder: (context, index) {
//                           var cartModel = data[index];
//                           var quantity = data[index].quantity;
//                           var product = data[index].product;

//                           return myCartListTile(
//                             context: context,
//                             cartModel: cartModel,
//                             quantity: quantity,
//                             data: data,
//                             index: index,
//                             product: product,
//                             onDeleteFN: () {
//                               if (quantity! > 1) {
//                                 setState(() {
//                                   data[index] = cartModel.copyWith(
//                                     quantity: quantity - 1,
//                                     // product: product?.copyWith(amount: decreasePrice()),
//                                   );
//                                 });
//                               } else {
//                                 // delete from cart
//                                 ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
//                                   map: {
//                                     ProductTypeEnums.productId.name:
//                                         cartModel.product!.id.toString(),
//                                   },
//                                 ).whenComplete(
//                                   () => ref.invalidate(getCartListProvider),
//                                 );
//                               }
//                             },
//                             onAddFN: () {
//                               if (quantity! < product!.availableQuantity!) {
//                                 setState(() {
//                                   data[index] = cartModel.copyWith(
//                                     quantity: quantity + 1,
//                                     // product: product?.copyWith(
//                                     //   amount: updatePrice(),
//                                     // ),
//                                   );
//                                 });
//                               } else {
//                                 showScaffoldSnackBarMessage(
//                                   '${cartModel.product!.name} is less than the available quantity of (${product.availableQuantity})',
//                                   isError: true,
//                                   duration: 2,
//                                 );
//                               }

//                               // foo.copyWith(quantity: 3);
//                             },
//                           );

//                           // MyCartListTileWidget(
//                           //   cartModel: cartModel,
//                           //   cartModelList: data,
//                           //   onDelete: () {
//                           //     ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
//                           //       map: {
//                           //         ProductTypeEnums.productId.name: cartModel.product!.id.toString(),
//                           //       },
//                           //     ).whenComplete(
//                           //       () => ref.invalidate(getCartListProvider),
//                           //     );
//                           //   },
//                           //   subtitleWidget: SizedBox(),
//                           // );
//                         },
//                       ),

//                       //
//                       Column(
//                         children: [
//                           SizedBox(
//                             width: context.sizeWidth(1),
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               child: Text(
//                                   '${TextConstant.checkout} ( ${TextConstant.nairaSign}${prices.toCommaPrices()} )'),
//                             ),
//                           ).padOnly(top: 30),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text(TextConstant.continueShopping),
//                           )
//                         ],
//                       ).padOnly(top: 10)
//                     ],
//                   );
//                 },
//                 error: (error, _) => Center(
//                   child: Text(error.toString()),
//                 ),
//                 loading: () => SizedBox(
//                   height: context.sizeHeight(0.6),
//                   child: const Center(
//                     child: CircularProgressIndicator.adaptive(),
//                   ),
//                 ),
//               )
//               .padSymmetric(horizontal: 10, vertical: 5),
//         ),
//       );
//     },
//   );
// }

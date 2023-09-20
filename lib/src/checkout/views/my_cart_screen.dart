import 'package:tago/app.dart';

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends ConsumerState<MyCartScreen> {
  // List<bool> checkBoxValueList = [];
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(getCartListProvider(true));
    ValueNotifier<List<CartModel>> cartItemsNotifier = ValueNotifier<List<CartModel>>(
      cartList.valueOrNull ?? [],
    );
    var prices = cartList.valueOrNull
        ?.map((e) => e.product?.amount)
        .fold(0, (previousValue, element) => previousValue + element!);
    int totalPrice1() {
      var omm = prices! + totalPrice;
      return omm;
    }

    return FullScreenLoader(
      isLoading: cartList.isLoading,
      child: Scaffold(
        appBar: appBarWidget(
          context: context,
          title: TextConstant.cart,
          isLeading: true,
        ),
        body: ListView(
          // itemExtent: 10,
          children: [
            cartList.when(
              data: (data) {
                List<CartModel> placeOrderModel = [...data];

                //
                return Column(
                  children: [
                    ...List.generate(
                      data.length,
                      (index) {
                        placeOrderModel[index].copyWith(quantity: 5);
                        var cartModel = data[index];

                        var quantity = data[index].quantity;
                        return ValueListenableBuilder(
                            valueListenable: cartItemsNotifier,
                            builder: (context, value, _) {
                              var foo = cartItemsNotifier.value[index];
                              void updateQuantity(int newQuantity) {
                                foo = cartModel.copyWith(
                                    quantity: newQuantity, product: ProductsModel(amount: 5000));
                                setState(() {
                                  // foo.quantity = newQuantity;
                                  // totalPrice = newQuantity * (cartModel.product!.amount)!;
                                  foo = cartModel.copyWith(
                                      quantity: newQuantity, product: ProductsModel(amount: 5000));
                                });
                              }

                              // double _calculateTotalPrice() {
                              //   double total = 0.0;
                              //   for (var item in cartItemsNotifier.value) {
                              //     total += item.quantity! * item.product!.amount!;
                              //   }
                              //   return total;
                              // }

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
                                      imgUrl: cartModel.product?.productImages?.last['image']
                                          ['url'],
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
                                                  (cartModel.product!.amount! * 1)
                                                      .toString()
                                                      .toCommaPrices(),
                                              // 'N1,879',
                                              style: context.theme.textTheme.titleMedium,
                                            ),
                                          ].columnInPadding(10),
                                        ),

                                        //subtitle
                                        subtitle: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            addMinusBTN(
                                              context: context,
                                              isMinus: true,
                                              isDelete: quantity! < 2 ? true : false,
                                              onTap: () {
                                                if (quantity > 1) {
                                                  updateQuantity((foo.quantity!) - 1);
                                                } else {
                                                  ref
                                                      .read(cartNotifierProvider.notifier)
                                                      .deleteFromCartMethod(
                                                    map: {
                                                      ProductTypeEnums.productId.name:
                                                          cartModel.product!.id.toString(),
                                                    },
                                                  ).whenComplete(
                                                    () => ref.invalidate(getCartListProvider),
                                                  );
                                                }
                                              },
                                            ),
                                            Text(
                                              foo.quantity.toString(),
                                              style: context.theme.textTheme.titleLarge,
                                            ),
                                            addMinusBTN(
                                              context: context,
                                              isMinus: false,
                                              onTap: () {
                                                log(placeOrderModel[index].quantity.toString());
                                                updateQuantity((foo.quantity)! + 1);
                                                // updateQuantity(index, (cartModel.quantity!) + 1);
                                              },
                                            ),
                                          ].rowInPadding(15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });

                        //   myCartListTile(
                        //     context: context,
                        //     key: Key('value $index'),
                        //     onTap: () { },
                        //     ref: ref,
                        //     cartModel: cartModel,
                        //     onDelete: () {
                        //       ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
                        //         map: {
                        //           ProductTypeEnums.productId.name: cartModel.product!.id.toString(),
                        //         },
                        //       ).whenComplete(
                        //         () => ref.invalidate(getCartListProvider),
                        //       );
                        //     },
                        //   );
                      },
                    ),
                    SizedBox(
                      width: context.sizeWidth(0.95),
                      child: ElevatedButton(
                        onPressed: () {
                          push(
                            context,
                            CheckoutScreen(
                              cartModel: data,
                              totalAmount: prices,
                              placeOrderModel: List.generate(
                                data.length,
                                (index) {
                                  return PlaceOrderModel(
                                    productId: '${data[index].product?.id}',
                                    quantity: '${data[index].quantity}',
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: Text(
                          TextConstant.proceedtoCheckout + totalPrice1().toString(),
                        ),
                      ).padAll(20),
                    ),
                  ],
                );
              },
              error: (error, _) => Text(error.toString()),
              loading: () => Column(
                children: List.generate(
                  3,
                  (index) => myCartListTileLoader(context),
                ).toList(),
              ),
            ),

            Text(HiveHelper().getData(HiveKeys.createOrder.keys) ?? 'addacecw')
          ],
        ),
      ),
    );
  }
}




//  MyCartListTileWidget(
//                           cartModel: cartModel,
//                           cartModelList: data,
//                           onDelete: () {},
//                           subtitleWidget: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               addMinusBTN(
//                                 context: context,
//                                 isMinus: true,
//                                 isDelete: quantity! < 2 ? true : false,
//                                 onTap: () {
//                                   if (quantity > 1) {
//                                     log(cartModel.product?.name ?? '');
//                                     updateQuantity(index, (cartModel.quantity!) - 1);
//                                   } else {
//                                     ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
//                                       map: {
//                                         ProductTypeEnums.productId.name:
//                                             cartModel.product!.id.toString(),
//                                       },
//                                     ).whenComplete(
//                                       () => ref.invalidate(getCartListProvider),
//                                     );
//                                   }
//                                 },
//                               ),
//                               Text(
//                                 quantity.toString(),
//                                 style: context.theme.textTheme.titleLarge,
//                               ),
//                               addMinusBTN(
//                                 context: context,
//                                 isMinus: false,
//                                 onTap: () {
//                                   updateQuantity(index, (cartModel.quantity!) + 1);
//                                 },
//                               ),
//                             ].rowInPadding(15),
//                           ),
//                         );
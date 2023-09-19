import 'package:tago/app.dart';

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends ConsumerState<MyCartScreen> {
  // List<bool> checkBoxValueList = [];

  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(getCartListProvider(true));

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

                var prices = placeOrderModel
                    .map((e) => e.product?.amount)
                    .fold(0, (previousValue, element) => previousValue + element!);
                return Column(
                  children: [
                    ...List.generate(
                      placeOrderModel.length,
                      (index) {
                        var cartModel = placeOrderModel[index];

                        void updateQuantity(int index, int newQuantity) {
                          setState(() {
                            // cartItemsNotifier.value[index].quantity = newQuantity;
                          });
                        }

                        var quantity = placeOrderModel[index].quantity;
                        return 
                        
                        
                        
                        
                        
                        MyCartListTileWidget(
                          cartModel: cartModel,
                          cartModelList: data,
                          onDelete: () {},
                          onTap: () {},
                          subtitleWidget: Row(
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
                                    log(cartModel.product?.name ?? '');
                                    updateQuantity(index, (cartModel.quantity!) - 1);
                                  } else {
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
                              ),
                              Text(
                                quantity.toString(),
                                style: context.theme.textTheme.titleLarge,
                              ),
                              addMinusBTN(
                                context: context,
                                isMinus: false,
                                onTap: () {
                                  updateQuantity(index, (cartModel.quantity!) + 1);
                                },
                              ),
                            ].rowInPadding(15),
                          ),
                        );

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
                          // push(
                          //   context,
                          //   CheckoutScreen(
                          //     cartModel: data,
                          //     totalAmount: prices,
                          //     placeOrderModel: List.generate(
                          //       data.length,
                          //       (index) {
                          //         return PlaceOrderModel(
                          //           productId: data[index].product?.id.toString(),
                          //           quantity: data[index].quantity.toString(),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // );
                        },
                        child: Text(
                          TextConstant.proceedtoCheckout + prices.toString(),
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
          ],
        ),
      ),
    );
  }
}

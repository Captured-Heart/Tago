import 'package:tago/app.dart';

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends ConsumerState<MyCartScreen> {
  @override
  void initState() {
    ref.read(getCartListProvider(true));
    super.initState();
  }

  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(getCartListProvider(true));
    // log(cartList.value!.map((e) => e.product!.amount).toString());

    int calculateTotalPrice() {
      int total = 0;
      for (var item in cartList.valueOrNull!) {
        total += item.quantity! * item.product!.amount!;
      }
      return total;
    }

    // log(calculateTotalPrice().toString());
    // log(HiveHelper().getData(HiveKeys.createOrder.keys).toString());
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
                if (data.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.cartArrowDown,
                        size: 84,
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
                  ).padOnly(top: 50);
                }
                //
                return Column(
                  children: [
                    ...List.generate(
                      data.length,
                      (index) {
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
                                );
                              });
                            } else {
                              // delete from cart
                              ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
                                map: {
                                  ProductTypeEnums.productId.name: cartModel.product!.id.toString(),
                                },
                              ).whenComplete(
                                () => ref.invalidate(getCartListProvider(false)),
                              );
                            }
                          },
                          onAddFN: () {
                            if (quantity! < product!.availableQuantity!) {
                              setState(() {
                                data[index] = cartModel.copyWith(
                                  quantity: quantity + 1,
                                );
                              });
                            }
                          },
                        );
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
                          '${TextConstant.proceedtoCheckout} (${TextConstant.nairaSign}${calculateTotalPrice().toString().toCommaPrices()})',
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
            // Text(HiveHelper().getData(HiveKeys.createOrder.keys).toString() ?? 'addacecw')
          ],
        ),
      ),
    );
  }
}

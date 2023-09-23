import 'package:tago/app.dart';

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends ConsumerState<MyCartScreen> {
  int totalPrice = 0;

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

                        int updatePrice() {
                          setState(() {});

                          var newPrice = quantity! * (product?.amount ?? 1);
                          return newPrice;
                        }

                        return Container(
                          width: context.sizeWidth(0.9),
                          padding: const EdgeInsets.only(
                              bottom: 10, top: 20, left: 10),
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
                                imgUrl: cartModel.product?.productImages
                                    ?.last['image']['url'],
                                height: 100,
                                width: 100,
                              ),
                              Expanded(
                                child: ListTile(
                                  minLeadingWidth: 80,
                                  // contentPadding: EdgeInsets.zero,
                                  visualDensity:
                                      VisualDensity.adaptivePlatformDensity,
                                  isThreeLine: true,

                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartModel.product!.name!,
                                        // 'Fanta Drink - 50cl Pet x 12 Fanta Drink Fanta Drink',
                                        style:
                                            context.theme.textTheme.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        TextConstant.nairaSign +
                                            // updatePrice()
                                            (cartModel.product!.amount!)
                                                .toString()
                                                .toCommaPrices(),
                                        // 'N1,879',
                                        style:
                                            context.theme.textTheme.titleMedium,
                                      ),
                                    ].columnInPadding(10),
                                  ),

                                  //subtitle
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // minus and delete button
                                      addMinusBTN(
                                        context: context,
                                        isMinus: true,
                                        isDelete: quantity! < 2 ? true : false,
                                        onTap: () {
                                          if (quantity > 1) {
                                            setState(() {
                                              data[index] = cartModel.copyWith(
                                                quantity: quantity - 1,
                                                // product: product?.copyWith(amount: decreasePrice()),
                                              );
                                            });
                                          } else {
                                            // delete from cart
                                            ref
                                                .read(cartNotifierProvider
                                                    .notifier)
                                                .deleteFromCartMethod(
                                              map: {
                                                ProductTypeEnums.productId.name:
                                                    cartModel.product!.id
                                                        .toString(),
                                              },
                                            ).whenComplete(
                                              () => ref.invalidate(
                                                  getCartListProvider),
                                            );
                                          }
                                        },
                                      ),
                                      Text(
                                        cartModel.quantity.toString(),
                                        style:
                                            context.theme.textTheme.titleLarge,
                                      ),

                                      //add button
                                      addMinusBTN(
                                        context: context,
                                        isMinus: false,
                                        onTap: () {
                                          if (quantity <
                                              product!.availableQuantity!) {
                                            setState(() {
                                              data[index] = cartModel.copyWith(
                                                quantity: quantity + 1,
                                                // product: product?.copyWith(
                                                //   amount: updatePrice(),
                                                // ),
                                              );
                                            });
                                          } else {
                                            showScaffoldSnackBarMessage(
                                              '${cartModel.product!.name} is less than the available quantity of (${product.availableQuantity})',
                                              isError: true,
                                              duration: 2,
                                            );
                                          }

                                          // foo.copyWith(quantity: 3);
                                        },
                                      ),
                                    ].rowInPadding(15),
                                  ),
                                ),
                              ),
                            ],
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
                          push(
                            context,
                            CheckoutScreen(
                              cartModel: data,
                              totalAmount: int.tryParse(
                                  calculateTotalPrice().toString()),
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

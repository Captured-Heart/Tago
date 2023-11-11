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
    return ValueListenableBuilder(
      valueListenable: HiveHelper().getCartsListenable(),
      builder: (BuildContext context, Box<List> box, Widget? child) {
        var cartList = (box.values)
            .map((dynamic e) => CartModel(quantity: e[0].quantity, product: e[0].product))
            .toList();

        int calculateTotalPrice() {
          int total = 0;
          for (var item in cartList) {
            total += item.quantity! * item.product!.amount!;
          }
          return total;
        }

        if (box.isNotEmpty) {
          return Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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
                  '${TextConstant.items} (${box.length})',
                  style: context.theme.textTheme.bodyLarge,
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: box.length,
                  controller: controller,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var product = cartList[index].product;
                    var cartModel = cartList[index];
              
                    var quantity = cartModel.quantity;
                    return myCartListTile(
                      context: context,
                      cartModel: cartModel,
                      quantity: quantity,
                      product: product,
                      onDeleteFN: () {
                        if (quantity! > 1) {
                          //! REDUCE THE QUANTITY
                          incrementDecrementCartValueMethod(
                            index,
                            CartModel(quantity: quantity - 1, product: product),
                          );
                        } else {
                          //! delete from the cart locally
                          deleteCartFromListMethod(
                            index: index,
                            cartModel: cartModel,
                            context: context,
                            setState: () => setState(() {}),
                          );
              
                          setState(() {});
                          //! DELETE FROM THE CART IN BACKEND
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
                          // INCREASING THE QUANTITY OF PRODUCT
                          incrementDecrementCartValueMethod(
                            index,
                            CartModel(quantity: quantity + 1, product: product),
                          );
                          setState(() {});
                        }
                      },
                    );
                  },
                ),
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
                            cartModel: cartList,
                            totalAmount: int.tryParse(calculateTotalPrice().toString()),
                            placeOrderModel: List.generate(
                              cartList.length,
                              (index) {
                                return PlaceOrderModel(
                                  amount: cartList[index].product!.amount,
                                  quantity: cartList[index].quantity,
                                  productId: '${cartList[index].product?.id}',
                                  product: cartList[index].product,
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
                  //! continue shopping button
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
          ).padSymmetric(horizontal: 10, vertical: 20));
        }

        // THIS RETURNS A PLACEHOLDER INDICATING NO PRODUCTS IN CART LIST
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FontAwesomeIcons.cartArrowDown,
              size: 60,
              color: TagoLight.textHint,
            ),
            Text(
              TextConstant.cartIsEmpty,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.titleLarge?.copyWith(
                fontWeight: AppFontWeight.w100,
                fontFamily: TextConstant.fontFamilyLight,
              ),
            )
          ].columnInPadding(20),
        ).padOnly(top: 50, bottom: 30);
      },
    );
  }
}

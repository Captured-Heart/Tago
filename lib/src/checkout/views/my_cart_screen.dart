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

  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    // log(cartList.value!.map((e) => e.product!.amount).toString());

    // int calculateTotalPrice() {
    //   int total = 0;
    //   for (var item in cartList.valueOrNull!) {
    //     total += item.quantity! * item.product!.amount!;
    //   }
    //   return total;
    // }

    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.cart,
        isLeading: true,
      ),
      body: ValueListenableBuilder(
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
            return ListView(
              controller: controller,
              children: [
                ListView.builder(
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
                SizedBox(
                  width: context.sizeWidth(0.95),
                  child: ElevatedButton(
                    onPressed: () {
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
                      '${TextConstant.proceedtoCheckout} (${TextConstant.nairaSign}${calculateTotalPrice().toString().toCommaPrices()})',
                    ),
                  ).padAll(20),
                ),
              ],
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                FontAwesomeIcons.cartArrowDown,
                size: 84,
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
          ).padOnly(top: 50);
        },
      ),
    );
  }
}

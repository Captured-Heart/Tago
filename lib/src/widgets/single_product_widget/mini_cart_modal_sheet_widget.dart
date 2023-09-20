import 'package:tago/app.dart';

Consumer singleProductMiniCartModalWidget() {
  ScrollController controller = ScrollController();

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
                  var prices = data
                      .map((e) => e.product?.amount)
                      .fold(0, (previousValue, element) => previousValue + element!)
                      .toString();

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
                          return MyCartListTileWidget(
                            cartModel: cartModel,
                            cartModelList: data,
                            onDelete: () {
                              ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
                                map: {
                                  ProductTypeEnums.productId.name: cartModel.product!.id.toString(),
                                },
                              ).whenComplete(
                                () => ref.invalidate(getCartListProvider),
                              );
                            },
                            subtitleWidget: SizedBox(),
                          );
                          // myCartListTile(
                          //   context: context,
                          //   ref: ref,
                          //   cartModel: cartModel,
                          //   onDelete: () {
                          //     ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
                          //       map: {
                          //         ProductTypeEnums.productId.name: cartModel.product!.id.toString(),
                          //       },
                          //     ).whenComplete(
                          //       () => ref.invalidate(getCartListProvider),
                          //     );
                          //   },
                          // );
                        },
                      ),

                      //
                      Column(
                        children: [
                          SizedBox(
                            width: context.sizeWidth(1),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                  '${TextConstant.checkout} ( ${TextConstant.nairaSign}${prices.toCommaPrices()} )'),
                            ),
                          ).padOnly(top: 30),
                          TextButton(
                            onPressed: () {},
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
                  height: context.sizeHeight(0.6),
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

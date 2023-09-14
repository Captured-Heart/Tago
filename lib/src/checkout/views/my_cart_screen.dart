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
                return ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var cartModel = data[index];
                    return myCartListTile(
                      context: context,
                      key: Key('value $index'),
                      onTap: () {
                        push(
                          context,
                          CheckoutScreen(
                            cartModel: cartModel,
                          ),
                        );
                      },
                      ref: ref,
                      cartModel: cartModel,
                      onDelete: () {
                        ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
                          map: {
                            ProductTypeEnums.productId.name: cartModel.product!.id.toString(),
                          },
                        ).whenComplete(
                          () => ref.invalidate(getCartListProvider),
                        );
                      },
                    );
                  },
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

            ElevatedButton(
              onPressed: () {
                push(
                  context,
                  CheckoutScreen(
                    cartModel: cartList.value![0],
                  ),
                );
              },
              child: const Text(TextConstant.proceedtoCheckout),
            ).padAll(20),
            // TextButton(
            //   onPressed: () {},
            //   child: const Text(TextConstant.proceedtoCheckout),
            // )
          ],
        ),
      ),
    );
  }
}

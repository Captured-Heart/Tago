import 'package:tago/app.dart';
import 'package:tago/config/utils/enums/product_type_enums.dart';
import 'package:tago/src/checkout/loaders/cart_list_tile_loaders.dart';

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends ConsumerState<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    // List cartList = List.generate(4, (index) => myCartListTile(context, ref));
    final cartList = ref.watch(getCartListProvider);

    return Scaffold(
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
                    onTap: () {
                      push(
                        context,
                        const CheckoutScreen(),
                      );
                    },
                    ref: ref,
                    cartModel: cartModel,
                    onDelete: () {
                      ref
                          .read(cartNotifierProvider.notifier)
                          .deleteFromCartMethod(
                        map: {
                          ProductTypeEnums.productId.name:
                              cartModel.product!.id.toString(),
                        },
                      ).whenComplete(() => ref.invalidate(getCartListProvider));
                    },
                  );
                },
              );
            },
            error: (error, _) => Text(error.toString()),
            loading: () => myCartListTileLoader(context),
          ),
          // TextButton(
          //   onPressed: () {},
          //   child: const Text('proceed to checkout screen'),
          // )
        ],
      ),
    );
  }
}

import 'package:tago/app.dart';
import 'package:tago/config/utils/enums/product_type_enums.dart';
import 'package:tago/src/checkout/loaders/cart_list_tile_loaders.dart';

final checkCartListProvider = StateProvider<List<bool>>((ref) {
  return [];
});

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends ConsumerState<MyCartScreen> {
  List<bool> checkBoxValueList = [];

  @override
  Widget build(BuildContext context) {
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
                  List<bool> checkBoxValues =
                      List.generate(data.length, (index) => false);

                  var cartModel = data[index];
                  return myCartListTile(
                    context: context,
                    key: Key('value $index'),
                    checkBoxValue: checkBoxValues[index],
                    onChanged: (value) {
                      // log(value.toString());
                      setState(() {
                        checkBoxValues[index] = value ?? false;
                        ref
                            .read(checkCartListProvider.notifier)
                            .update((state) => checkBoxValues);
                        // checkBoxValues.add(value);
                        checkBoxValueList.add(value ?? false);
                      });
                      log(' checkbox values in index: $index ${checkBoxValues}');
                    },
                    onTap: () {
                      // push(
                      //   context,
                      //   const CheckoutScreen(),
                      // );
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
          !ref.watch(checkCartListProvider).contains(true)
              ? const SizedBox.shrink()
              : ElevatedButton(
                  onPressed: () {
                    push(
                      context,
                      const CheckoutScreen(),
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
    );
  }
}

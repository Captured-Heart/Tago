import 'package:tago/app.dart';

class WishListScreen extends ConsumerWidget {
  WishListScreen({super.key});

  final List<CartModel> recentProducts = [];

  void saveToCartLocalStorage(CartModel cartModel) {
    final myData = HiveHelper().getCartsList(defaultValue: recentProducts) as List<CartModel>;

    final updatedData = [...myData, cartModel];
    HiveHelper().saveCartsToList(updatedData);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishList = ref.watch(fetchWishListProvider(false));
    var cartList = ref.watch(getCartListProvider(false));
    var wishListID = wishList.valueOrNull?.map((e) => e.id).toList();
    log('wishListID: $wishListID');
    var cartListID = cartList.valueOrNull?.map((e) => e.product?.id ?? 0).toList();
    log('cartListID: $cartListID');
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.mywishlist,
        isLeading: true,
        suffixIcon: IconButton(
          onPressed: () {
            navBarPush(
              context: context,
              screen: const MyCartScreen(),
              withNavBar: false,
            );
          },
          icon: Badge(
            backgroundColor: TagoLight.orange,
            smallSize: 10,
            isLabelVisible: cartList.valueOrNull?.isNotEmpty ?? false,
            child: const Icon(Icons.shopping_cart_outlined),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          wishList.when(
            data: (data) {
              return Column(
                children: List.generate(data.length, (index) {
                  // var wishList = convertDynamicListToProductListModel(data)[index];
                  var wishListIndex = data[index];
                  var isInCartAlready = checkIdenticalListsWithInt(
                    list1: cartListID ?? [],
                    int: wishListIndex.id!,
                  );

                  log(isInCartAlready.toString());
                  return wishlistWidget(
                    context: context,
                    productsModel: wishListIndex,
                    isInCartAlready: isInCartAlready,
                    onAddToCart: () {
                      if (wishListIndex.availableQuantity! < 1) {
                        //product is out of stock
                        showScaffoldSnackBarMessage(
                          TextConstant.productIsOutOfStock,
                          isError: true,
                        );
                        saveToCartLocalStorage(CartModel(quantity: 1, product: wishListIndex));
                      } else {
                        saveToCartLocalStorage(CartModel(quantity: 1, product: wishListIndex));

                        ref.read(cartNotifierProvider.notifier).addToCartMethod(
                          map: {
                            ProductTypeEnums.productId.name: wishListIndex.id.toString(),
                            ProductTypeEnums.quantity.name: '1',
                          },
                        ).whenComplete(() => ref.invalidate(getCartListProvider));
                      }
                      inspect(wishListIndex);
                    },
                    deleteFromCart: () {
                      ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
                        map: {
                          ProductTypeEnums.productId.name: wishListIndex.id.toString(),
                        },
                      ).whenComplete(() => ref.invalidate(getCartListProvider));
                    },
                  );
                }),
              );

              // const Text('data');
            },
            error: (error, _) => Center(
              child: Center(child: Text(NetworkErrorEnums.checkYourNetwork.message)),
            ),
            loading: () => Column(
              children: List.generate(
                3,
                (index) => myCartListTileLoader(context),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

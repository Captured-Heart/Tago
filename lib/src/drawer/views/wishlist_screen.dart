import 'package:tago/app.dart';

class WishListScreen extends ConsumerStatefulWidget {
  const WishListScreen({super.key});

  @override
  ConsumerState<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends ConsumerState<WishListScreen> {
  // final List<CartModel> recentProducts = [];
  @override
  Widget build(BuildContext context) {
    final wishList = ref.watch(fetchWishListProvider(false));
    var wishListID = wishList.valueOrNull?.map((e) => e.id).toList();
    log('wishListID: $wishListID');

    var cartListID = checkCartBoxLength()!.map((e) => e.product!.id).toList();
    setState(() {
      checkCartBoxLength();
    });

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
            isLabelVisible: checkCartBoxLength()?.isNotEmpty ?? false,
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
                    list1: cartListID,
                    int: wishListIndex.id!,
                  );
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
                      } else {
                        //add to cart (LOCALLY)
                        saveToCartLocalStorageMethod(
                          CartModel(quantity: 1, product: wishListIndex),
                        );
                        setState(() {});

                        // add to cart (BACKEND)
                        ref.read(cartNotifierProvider.notifier).addToCartMethod(
                          map: {
                            ProductTypeEnums.productId.name: wishListIndex.id.toString(),
                            ProductTypeEnums.quantity.name: '1',
                          },
                        ).whenComplete(() => ref.invalidate(getCartListProvider));
                      }
                    },

                    //! I REMOVED THIS METHOD HERE, BECAUSE WE CAN'T GET THE ACCURATE INDEX OF THE CARTLIST SAVED LOCALLY IN THE WISHLIST. THEY ARE INDEPENDENTLY CO-EXISTING
                    // deleteFromCart: () {
                    //   deleteCartFromListMethod(
                    //     index: index,
                    //     context: context,
                    //     cartModel: CartModel(product: wishListIndex),
                    //   );
                    //   //delete from cart(BACKEND)
                    //   ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
                    //     map: {
                    //       ProductTypeEnums.productId.name: wishListIndex.id.toString(),
                    //     },
                    //   ).whenComplete(() => ref.invalidate(getCartListProvider));
                    // },
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

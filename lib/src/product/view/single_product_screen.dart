import 'package:tago/app.dart';
import 'package:tago/src/product/models/domain/product_specifications_model.dart';

class SingleProductPage extends ConsumerStatefulWidget {
  const SingleProductPage({
    super.key,
    required this.id,
    required this.productsModel,
  });
  final int id;
  final ProductsModel productsModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SingleProductPageState();
}

class _SingleProductPageState extends ConsumerState<SingleProductPage> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(getProductsProvider(widget.id.toString()));

    var wishlist = ref.watch(fetchWishListProvider(false));
    var cartList = ref.watch(getCartListProvider(false));
    var wishListID = wishlist.value?.map((e) => e.id).contains(widget.id);

    var cartListID = cartList.valueOrNull
        ?.map((e) => e.product?.id ?? 0)
        .toList()
        .contains(widget.id);
    // var wishListID = checkIdenticalListsWithInt(list1: wishListList, int: widget.id);
    final productSpecs = ref.watch(productSpecificationsProvider);
    final relatedProducts = ref.watch(relatedProductsProvider);
    return FullScreenLoader(
      isLoading: ref.read(postToWishListNotifierProvider).isLoading ||
          ref.watch(cartNotifierProvider).isLoading,
      child: Scaffold(
        appBar: appBarWidget(
          context: context,
          title: products.valueOrNull?.label?.toTitleCase() ?? '',
          isLeading: true,
          suffixIcon: IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isDismissible: false,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
                builder: (context) {
                  return singleProductMiniCartModalWidget();
                },
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(
              height: context.sizeHeight(0.5),
              width: context.sizeWidth(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: cachedNetworkImageWidget(
                      imgUrl: products
                          .valueOrNull?.productImages?.first['image']['url'],
                      isProgressIndicator: true,
                      height: context.sizeHeight(1),
                      width: context.sizeWidth(1),
                    ),
                  ),
                  Text(
                      'quantity: ${widget.productsModel.availableQuantity.toString()}'),
                  singleProductListTileWidget(
                    context: context,
                    products: products,
                  ).padSymmetric(horizontal: 10, vertical: 5),
                  Column(
                      children: [
                    cartListID == true
                        ? ValueListenableBuilder(
                            valueListenable:
                                ref.watch(valueNotifierProvider(0)),
                            builder: (context, value, child) {
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  addMinusBTN(
                                    context: context,
                                    isMinus: true,
                                    onTap: () {
                                      if (value > 1) {
                                        // ref.read(valueNotifierProvider(0)).value--;
                                      }
                                    },
                                  ),
                                  Text(
                                    value.toString(),
                                    style: context.theme.textTheme.titleMedium,
                                  ),
                                  addMinusBTN(
                                    context: context,
                                    onTap: () {
                                      // ref.read(valueNotifierProvider(0)).value++;
                                    },
                                  ),
                                ],
                              );
                            },
                          )
                        : SizedBox(
                            width: context.sizeWidth(1),
                            child: widget.productsModel.availableQuantity! < 1
                                ? ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          TagoLight.textFieldBorder,
                                      elevation: 0,
                                    ),
                                    child: const Text(TextConstant.addtocart),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      ref
                                          .read(cartNotifierProvider.notifier)
                                          .addToCartMethod(
                                        map: {
                                          ProductTypeEnums.productId.name:
                                              widget.id.toString(),
                                          ProductTypeEnums.quantity.name: '1',
                                        },
                                      ).whenComplete(() => ref.invalidate(
                                              getCartListProvider(false)));
                                    },
                                    child: const Text(TextConstant.addtocart),
                                  ),
                          ),
                    widget.productsModel.availableQuantity! < 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.favorite_outline),
                              Text(
                                TextConstant.saveforlater,
                                textScaleFactor: 1.2,
                                textAlign: TextAlign.center,
                              ),
                            ].rowInPadding(8))
                        : TextButton.icon(
                            onPressed: () {
                              if (wishListID != true) {
                                ref
                                    .read(
                                        postToWishListNotifierProvider.notifier)
                                    .postToWishListMethod(
                                  map: {
                                    ProductTypeEnums.productId.name:
                                        widget.id.toString()
                                  },
                                ).whenComplete(() => ref
                                        .watch(fetchWishListProvider(false)));
                              }
                            },
                            icon: wishListID == true
                                ? const Icon(Icons.favorite)
                                : const Icon(Icons.favorite_border_outlined),
                            label: wishListID == true
                                ? const Text(TextConstant.saved)
                                : const Text(TextConstant.saveforlater),
                          )
                  ].columnInPadding(10)),
                ],
              ),
            ),

            //
            ListTile(
              title: const Text(
                TextConstant.itemsDetails,
              ),
              subtitle: Text(
                products.valueOrNull?.description ??
                    'The most delicate moment requires impeccable precision.',
                style:
                    context.theme.textTheme.bodyMedium?.copyWith(height: 1.7),
              ).padSymmetric(vertical: 10),
            ),

            //PRODUCT SPECIFICATIONS SECTIONS
            singleProductSpecificationsWidget(context, productSpecs)
                .padOnly(bottom: 20),

            // RATINGS AND REVIEWS
            products.when(
              data: (data) {
                return singleProductRatingsAndReviewsWidget(
                    data, context, products);
              },
              error: (error, _) {
                return Text(error.toString());
              },
              loading: () => const CircularProgressIndicator.adaptive(),
            ),

            //SIMILAR ITEMS
            const ListTile(
              title: Text(
                TextConstant.similiarItems,
              ),
            ),

            SizedBox(
              height: 220,
              child: ListView.builder(
                itemCount: products.valueOrNull?.relatedProducts?.length,
                shrinkWrap: false,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: context.sizeWidth(0.35),
                    child: singleProductSimilarItemCardWidget(
                      // index: index,
                      productsModel: relatedProducts[index],

                      //TODO: REPLACE THE [0] WITH INDEX
                      context: context,
                      image: relatedProducts[0].productImages?.last['image']
                              ['url'] ??
                          noImagePlaceholderHttp,
                      onTap: () {
                        // navBarPush(
                        //   context: context,
                        //   screen: SingleProductPage(
                        //     appBarTitle: drinkTitle[index],
                        //     image: drinkImages[index],
                        //   ),
                        //   withNavBar: false,
                        // );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container singleProductSpecificationsWidget(
      BuildContext context, List<ProductSpecificationsModel>? productSpec) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(width: 0.1, strokeAlign: BorderSide.strokeAlignInside),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //product specifications
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 0.1),
            )),
            child: Text(
              TextConstant.productSpecifications,
              style: context.theme.textTheme.titleMedium,
            ),
          ),

          //weight
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 0.1),
            )),

            //TODO: THE ERROR OF BAD STATE IS HERE
            child: Text(
              // ignore: sdk_version_since
              productSpec?.firstOrNull?.title ?? 'Weight',
              style: context.theme.textTheme.bodyLarge,
            ),
          ),
          //SKU
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  TextConstant.sku,
                  style: context.theme.textTheme.bodyLarge,
                ),
                const Text('1FDITDKCTU34565hj')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container singleProductRatingsAndReviewsWidget(ProductsModel data,
      BuildContext context, AsyncValue<ProductsModel> products) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(width: 0.1, strokeAlign: BorderSide.strokeAlignInside),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //product specifications
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 0.1),
            )),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${TextConstant.ratingandReviews} (${data.productReview?.length})',
                  style: context.theme.textTheme.titleMedium,
                ),
                TextButton(
                    onPressed: () {
                      navBarPush(
                        context: context,
                        screen: RatingsAndReviewsScreen(
                          id: widget.id,
                        ),
                        withNavBar: false,
                      );
                    },
                    child: const Text(TextConstant.seeall))
              ],
            ),
          ),

          //ratings card
          ...List.generate(
            data.productReview!.length > 2
                ? data.productReview!.length - (data.productReview!.length - 2)
                : data.productReview!.length,
            // data.productReview?.length  ?? 1,
            (index) => ratingsCard(
              context: context,
              productsModel: products,
              index: index,
            ),
          )
        ],
      ),
    );
  }
}

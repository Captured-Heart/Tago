import 'package:tago/app.dart';

class SingleProductPage extends ConsumerStatefulWidget {
  const SingleProductPage({
    super.key,
    required this.id,
    required this.productsModel,
  });
  final int id;
  final ProductsModel productsModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends ConsumerState<SingleProductPage> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(getProductsProvider(widget.id.toString()));

    var wishlist = ref.watch(fetchWishListProvider(false));
    var cartList = ref.watch(getCartListProvider(false));
    var wishListID = wishlist.value?.map((e) => e.id).contains(widget.id);
    var cartListLength = cartList.valueOrNull;

    var cartListID =
        cartList.valueOrNull?.map((e) => e.product?.id ?? 0).toList().contains(widget.id);
    // var wishListID = checkIdenticalListsWithInt(list1: wishListList, int: widget.id);
    final productSpecs = ref.watch(productSpecificationsProvider);

    log('preducts Specs: ${products.valueOrNull?.productReview!.map((e) => e['rating']).toList()}');
    final relatedProducts = ref.watch(relatedProductsProvider);

    return FullScreenLoader(
      isLoading: ref.read(postToWishListNotifierProvider).isLoading ||
          ref.watch(cartNotifierProvider).isLoading,
      child: Scaffold(
        appBar: appBarWidget(
          context: context,
          title: products.valueOrNull?.name?.toTitleCase() ?? '',
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
                  ),
                ),
                builder: (context) {
                  return const SingleProductMiniCartModalWidget();
                },
              );
            },
            icon: Badge(
              isLabelVisible: checkCartBoxLength()?.isNotEmpty ?? false,

              // isLabelVisible: cartListLength?.isNotEmpty ?? false,
              backgroundColor: TagoLight.orange,
              smallSize: 10,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CarouselSlider(
                            items: List.generate(
                              widget.productsModel.productImages!.length,
                              (index) => cachedNetworkImageWidget(
                                imgUrl: widget.productsModel.productImages?[index]['image']['url'],
                                //  products.valueOrNull?.productImages?.first['image']['url'],
                                isProgressIndicator: true,
                                height: context.sizeHeight(1),
                                width: context.sizeWidth(1),
                              ),
                            ),
                            carouselController: ref.watch(carouselSliderProvider),
                            options: CarouselOptions(
                              autoPlay: false,
                              // aspectRatio: 20 / 9,
                              enlargeCenterPage: false,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.99,
                              enlargeFactor: 3,
                              onPageChanged: (index, reason) {
                                ref
                                    .read(currentCarouselIndexProvider.notifier)
                                    .update((state) => index);
                              },
                            ),
                          ),
                        ),
                        widget.productsModel.productImages!.length < 2
                            ? const SizedBox.shrink()
                            : carouselIndicator(
                                    context, widget.productsModel.productImages!.length, ref)
                                .padOnly(top: 10),
                      ],
                    ),
                  ),
                  // Text('id: ${widget.productsModel.availableQuantity.toString()}'),
                  singleProductListTileWidget(
                    context: context,
                    products: products,
                  ).padSymmetric(horizontal: 10, vertical: 5),
                  Column(
                      children: [
                    cartListID == true
                        ? SizedBox(
                            width: context.sizeWidth(1),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  // fixedSize: const Size.fromHeight(25),
                                  visualDensity: VisualDensity.compact,
                                  // foregroundColor: TagoLight.primaryColor,
                                  backgroundColor: TagoLight.primaryColor.withOpacity(0.15)),
                              child: Text(
                                TextConstant.savedToCart,
                                style: context.theme.textTheme.titleMedium?.copyWith(
                                  color: TagoDark.textError.withOpacity(0.6),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: context.sizeWidth(1),
                            child: widget.productsModel.availableQuantity! < 1
                                ? ElevatedButton(
                                    onPressed: () {
                                      showScaffoldSnackBarMessage(TextConstant.productIsOutOfStock,
                                          isError: true);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: TagoLight.textFieldBorder,
                                      elevation: 0,
                                    ),
                                    child: const Text(TextConstant.addtocart),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      //add to cart (LOCALLY)
                                      saveToCartLocalStorageMethod(
                                        CartModel(quantity: 1, product: widget.productsModel),
                                      );
                                      // add to cart (BACKEND)
                                      ref.read(cartNotifierProvider.notifier).addToCartMethod(
                                        map: {
                                          ProductTypeEnums.productId.name:
                                              widget.productsModel.id.toString(),
                                          ProductTypeEnums.quantity.name: '1',
                                        },
                                      );
                                      ref.invalidate(getCartListProvider(false));
                                    },
                                    child: const Text(TextConstant.addtocart),
                                  ),
                          ),
                    TextButton.icon(
                      onPressed: () {
                        ref.read(postToWishListNotifierProvider.notifier).postToWishListMethod(
                          map: {ProductTypeEnums.productId.name: widget.id.toString()},
                        ).whenComplete(() => ref.invalidate(fetchWishListProvider(false)));
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
              subtitle: products.isLoading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        4,
                        (index) => shimmerWidget(
                          child: SizedBox(
                            width: context.sizeWidth(0.95),
                            child: const LinearProgressIndicator(
                              minHeight: 12,
                            ).padSymmetric(vertical: 3, horizontal: 10),
                          ),
                        ),
                      ),
                    ).padSymmetric(vertical: 10)
                  : Text(
                      products.valueOrNull?.description ?? '',
                      style: context.theme.textTheme.bodyMedium?.copyWith(height: 1.7),
                    ).padSymmetric(vertical: 10),
            ),

            //PRODUCT SPECIFICATIONS SECTIONS
            singleProductSpecificationsWidget(context, productSpecs).padOnly(bottom: 20),

            // RATINGS AND REVIEWS
            products.when(
              data: (data) {
                return singleProductRatingsAndReviewsWidget(data, context, products);
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

            products.value?.relatedProducts == null
                ? const SizedBox.shrink()
                : SizedBox(
                    height: 220,
                    width: context.sizeWidth(1),
                    child: ListView.builder(
                      itemCount: relatedProducts.length,
                      shrinkWrap: false,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      itemBuilder: (context, index) {
                        if (products.value?.relatedProducts != null) {
                          return SizedBox(
                            width: context.sizeWidth(0.38),
                            child: singleProductSimilarItemCardWidget(
                              // index: index,
                              productsModel: relatedProducts[index],

                              context: context,
                              image: relatedProducts[index].productImages!.isNotEmpty
                                  ? relatedProducts[index].productImages?.first['image']['url']
                                  : noImagePlaceholderHttp,
                              onTap: () {
                                navBarPush(
                                  context: context,
                                  popFirst: true,
                                  screen: SingleProductPage(
                                    id: relatedProducts[index].id!,
                                    productsModel: relatedProducts[index],
                                  ),
                                  withNavBar: false,
                                );
                              },
                            ),
                          );
                        }
                        return const Center(
                          child: Text(TextConstant.sorryNoProductsInCategory),
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
        border: Border.all(width: 0.1, strokeAlign: BorderSide.strokeAlignInside),
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

  Container singleProductRatingsAndReviewsWidget(
      ProductsModel data, BuildContext context, AsyncValue<ProductsModel> products) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.1, strokeAlign: BorderSide.strokeAlignInside),
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

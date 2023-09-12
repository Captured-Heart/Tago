import 'package:tago/app.dart';

class SingleProductPage extends ConsumerStatefulWidget {
  const SingleProductPage({
    super.key,
    required this.id,
  });
  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SingleProductPageState();
}

class _SingleProductPageState extends ConsumerState<SingleProductPage> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(getProductsProvider(widget.id.toString()));
    // log(products.valueOrNull?.relatedProducts.toString() ?? '');
    var productSpec = convertDynamicListToProductSpecificationsModel(
        products.valueOrNull!.productSpecification!);
    var relatedProducts = convertDynamicListToProductListModel(
        products.valueOrNull?.relatedProducts ?? []);
    var wishlist = ref.watch(fetchWishListProvider);
    var cartList = ref.watch(cartNotifierProvider);

    var wishListID = wishlist.value!.map((e) => e.id).contains(widget.id);
    log(cartList.toString());

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
                  return miniCartModalWIdget();
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
                        imgUrl: products.valueOrNull?.productImages
                                ?.first['image']['url'] ??
                            noImagePlaceholderHttp,
                        height: context.sizeHeight(1),
                        width: context.sizeWidth(1)),
                  ),
                  singlePageProductListTile(
                    context: context,
                    products: products,
                  ).padSymmetric(horizontal: 10, vertical: 5),
                  Column(
                      children: [
                    ref.watch(cartNotifierProvider).hasError
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
                                        ref
                                            .read(valueNotifierProvider(0))
                                            .value--;
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
                                      ref
                                          .read(valueNotifierProvider(0))
                                          .value++;
                                    },
                                  ),
                                ],
                              );
                            },
                          )
                        : SizedBox(
                            width: context.sizeWidth(1),
                            child: ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(cartNotifierProvider.notifier)
                                    .addToCartMethod(
                                  map: {
                                    ProductTypeEnums.productId.name:
                                        widget.id.toString(),
                                    ProductTypeEnums.quantity.name: '1',
                                  },
                                );
                              },
                              child: const Text(TextConstant.addtocart),
                            ),
                          ),
                    TextButton.icon(
                      onPressed: () {
                        if (wishListID != true) {
                          ref
                              .read(postToWishListNotifierProvider.notifier)
                              .postToWishListMethod(
                            map: {
                              ProductTypeEnums.productId.name:
                                  widget.id.toString()
                            },
                          );
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
                    'The most delicate moment requires impeccable precision. At CallToInspiration we know perfectly well that this step is crucial, which is why we have collected all the examples to ensure that the purchase is like a work of art! Get inspired!',
                style:
                    context.theme.textTheme.bodyMedium?.copyWith(height: 1.7),
              ).padSymmetric(vertical: 10),
            ),

            //PRODUCT SPECIFICATIONS SECTIONS
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 0.1, strokeAlign: BorderSide.strokeAlignInside),
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
                    child: Text(
                      productSpec.first.title ?? 'Weight',
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
            ).padOnly(bottom: 20),

            // RATINGS AND REVIEWS
            products.when(
              data: (data) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.1, strokeAlign: BorderSide.strokeAlignInside),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //product specifications
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
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
                                  push(
                                    context,
                                    const RatingsAndReviewsScreen(),
                                  );
                                  // navBarPush(
                                  //   context: context,
                                  //   screen: const RatingsAndReviewsScreen(),
                                  //   withNavBar: false,
                                  // );
                                },
                                child: const Text(TextConstant.seeall))
                          ],
                        ),
                      ),

                      //ratings card
                      ...List.generate(
                        data.productReview!.length > 2
                            ? data.productReview!.length -
                                (data.productReview!.length - 2)
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

            // ...List.generate(
            //   products.value?.relatedProducts?.length ?? 1,
            //   (index) => SizedBox(
            //     width: context.sizeWidth(0.35),
            //     child: itemsNearYouCard(
            //       // index: index,
            //       productsModel: relatedProducts[index],
            //       context: context,
            //       image: noImagePlaceholderHttp,
            //       onTap: () {
            //         // navBarPush(
            //         //   context: context,
            //         //   screen: SingleProductPage(
            //         //     appBarTitle: drinkTitle[index],
            //         //     image: drinkImages[index],
            //         //   ),
            //         //   withNavBar: false,
            //         // );
            //       },
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                itemCount: relatedProducts.length,
                shrinkWrap: false,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: context.sizeWidth(0.35),
                    child: singlePageCard(
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

  Widget singlePageCard({
    // required int index,
    required ProductsModel? productsModel,
    required BuildContext context,
    VoidCallback? onTap,
    required String image,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0.3,
            child: cachedNetworkImageWidget(
              imgUrl: image,
              height: 140,
            ),
          ),
          Text(
            productsModel?.label ?? '',
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: context.theme.textTheme.labelMedium?.copyWith(
              fontSize: 12,
              fontWeight: AppFontWeight.w500,
              fontFamily: TextConstant.fontFamilyNormal,
            ),
          ).padSymmetric(vertical: 8),
          Text(
            '${TextConstant.nairaSign} ${productsModel?.amount.toString().toCommaPrices() ?? '1000'}',
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontFamily: TextConstant.fontFamilyNormal,
              fontSize: 12,
            ),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }

  Consumer miniCartModalWIdget() {
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
                          .fold(
                              0,
                              (previousValue, element) =>
                                  previousValue + element!)
                          .toString();

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              '${TextConstant.items} (${data.length})',
                              style: context.theme.textTheme.bodyLarge,
                            ),
                          ),
                          ListView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var cartModel = data[index];
                              return myCartListTile(
                                context: context,
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
                          ),
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
                                child:
                                    const Text(TextConstant.continueShopping),
                              )
                            ],
                          ).padOnly(bottom: 10)
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
                  .padSymmetric(horizontal: 10, vertical: 5)),
        );
      },
    );
  }

  Column singlePageProductListTile({
    required BuildContext context,
    required AsyncValue<ProductsModel>? products,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //title
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
              products!.valueOrNull?.label?.toTitleCase() ?? '',
              style: context.theme.textTheme.labelMedium,
            ).padOnly(right: 15)),
            Container(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: TagoDark.orange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'save ${products.valueOrNull?.savedPerc}%',
                style: context.theme.textTheme.labelLarge?.copyWith(
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),

        //subtitle
        Text(
          TextConstant.nairaSign +
              double.parse(products.valueOrNull?.amount.toString() ?? '0')
                  .toString()
                  .toCommaPrices(),
          style: context.theme.textTheme.titleMedium,
        ).padOnly(left: 10),

        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.star,
              color: TagoDark.orange,
            ).padOnly(right: 6),
            const Text('3.5')
          ],
        )
      ].columnInPadding(5),
    );
  }
}

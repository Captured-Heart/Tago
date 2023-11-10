import 'package:tago/app.dart';

class ProductCard extends ConsumerStatefulWidget {
  const ProductCard({
    super.key,
    required this.productModel,
    // required this.quantity,
  });
  final ProductsModel productModel;
  // final int quantity;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var cartIndex = cartIndexFromID(widget.productModel)!;
    var quantity = cartQuantityFromName(widget.productModel);

    return GestureDetector(
      // key: UniqueKey(),
      onTap: () {
        addRecentlyViewedToStorage(widget.productModel);

        navBarPush(
          context: context,
          screen: SingleProductPage(
            id: widget.productModel.id ?? 0,
            productsModel: widget.productModel,
          ),
          withNavBar: false,
        );
      },
      child: Container(
          // key: UniqueKey(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          width: 180,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cachedNetworkImageWidget(
                imgUrl: widget.productModel.productImages!.first['image']['url'],
                height: 140,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.productModel.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.theme.textTheme.labelMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: AppFontWeight.w500,
                  fontFamily: TextConstant.fontFamilyNormal,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${TextConstant.nairaSign} ${widget.productModel.amount}',
                      style: context.theme.textTheme.titleLarge?.copyWith(
                        fontFamily: TextConstant.fontFamilyNormal,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  checkCartBoxLength()
                              ?.map((e) => e.product?.id)
                              .toList()
                              .contains(widget.productModel.id) ==
                          true
                      ? Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          decoration: BoxDecoration(
                              color: TagoLight.primaryColor.withOpacity(0.13),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //decrease
                              GestureDetector(
                                // onTap: onDecrementBTN,
                                onTap: () {
                                  if (quantity! > 1) {
                                    //! REDUCE THE widget.QUANTITY
                                    incrementDecrementCartValueMethod(
                                      cartIndex,
                                      // cartIndexFromID(widget.productModel)!,
                                      CartModel(
                                          quantity: quantity - 1,
                                          product: widget.productModel),
                                    );
                                    setState(() {});
                                  } else {
                                    //! delete from the cart locally
                                    deleteCartFromListMethod(
                                      index: cartIndexFromID(widget.productModel)!,
                                      cartModel: CartModel(),
                                      context: context,
                                      setState: () {},
                                      isProductModel: true,
                                      productsModel: widget.productModel,
                                    );
                                    setState(() {});
                                    //! DELETE FROM THE CART IN BACKEND
                                    ref.read(cartNotifierProvider.notifier).deleteFromCartMethod(
                                      map: {
                                        ProductTypeEnums.productId.name:
                                            widget.productModel.id.toString(),
                                      },
                                    ).whenComplete(
                                      () => ref.invalidate(getCartListProvider(false)),
                                    );
                                    setState(() {});
                                  }
                                },
                                child: const Icon(
                                  Icons.remove,
                                  size: 22,
                                  color: TagoLight.primaryColor,
                                ),
                              ),
                              Text(
                                // '${cartQuantityFromName(widget.productModel) ?? 1}',
                                quantity.toString(),
                                style: context.theme.textTheme.titleMedium,
                              ),

                              //increase
                              GestureDetector(
                                // onTap: onIncrementBTN,
                                onTap: () {
                                  if (quantity! < widget.productModel.availableQuantity!) {
                                    log('increased: ${cartIndexFromID(widget.productModel)!} ');

                                    incrementDecrementCartValueMethod(
                                      // cartIndexFromID(widget.productModel)!,
                                      cartIndex,
                                      CartModel(
                                          quantity: quantity + 1,
                                          product: widget.productModel),
                                    );
                                    setState(() {});
                                  } else {
                                    showScaffoldSnackBarMessage(
                                      'The available widget.quantity of ${widget.productModel.name} is (${widget.productModel.availableQuantity})',
                                      isError: true,
                                      duration: 2,
                                    );
                                    setState(() {});
                                  }
                                },
                                child: const Icon(
                                  Icons.add,
                                  size: 22,
                                  color: TagoLight.primaryColor,
                                ),
                              ),
                            ].rowInPadding(7),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              border: Border.all(color: TagoDark.primaryColor)),
                          child: GestureDetector(
                            // onTap: addToCartBTN,
                            onTap: () {
                              if (widget.productModel.availableQuantity! < 1) {
                                //product is out of stock
                                showScaffoldSnackBarMessage(
                                  TextConstant.productIsOutOfStock,
                                  isError: true,
                                );
                                setState(() {});
                              } else {
                                //add to cart (LOCALLY)
                                saveToCartLocalStorageMethod(
                                  CartModel(quantity: 1, product: widget.productModel),
                                );
                                setState(() {});

                                // add to cart (BACKEND)
                                ref.read(cartNotifierProvider.notifier).addToCartMethod(
                                  map: {
                                    ProductTypeEnums.productId.name:
                                        widget.productModel.id.toString(),
                                    ProductTypeEnums.quantity.name: '1',
                                  },
                                );
                                ref.invalidate(getCartListProvider(false));
                              }
                              setState(() {});
                            },
                            child: Text(
                              'Add',
                              style: context.theme.textTheme.titleMedium?.copyWith(
                                  fontFamily: TextConstant.fontFamilyNormal,
                                  fontSize: 12,
                                  color: TagoDark.orange),
                            ),
                          ),
                        )
                ],
              )
            ],
          )),
    );
  }
}

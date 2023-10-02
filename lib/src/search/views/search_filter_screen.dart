import 'package:tago/app.dart';

class SearchFilterScreen extends ConsumerStatefulWidget {
  const SearchFilterScreen({
    super.key,
    required this.controller,
    this.product,
  });
  final TextEditingControllerClass controller;
  final List<ProductsModel>? product;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends ConsumerState<SearchFilterScreen> {
  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(getCartListProvider(false)).valueOrNull;
    final keyWord = ref.watch(searchTextProvider);
    log('data gotten from search screen: ${widget.product.toString()}');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              minLeadingWidth: 5,
              horizontalTitleGap: 3,
              leading: const BackButton(),
              title: authTextFieldWithError(
                controller: widget.controller.searchProductController,
                context: context,
                prefixIcon: const Icon(Icons.search),
                isError: false,
                autoFocus: true,
                filled: true,
                onChanged: (value) {
                  ref.read(searchTextProvider.notifier).update((state) => value);
                },
                suffixIcon: IconButton.outlined(
                  onPressed: () {
                    widget.controller.searchProductController.clear();
                    ref.read(searchTextProvider.notifier).update((state) => '');
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ),
              trailing: IconButton.outlined(
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

                  // isLabelVisible: cartList?.isNotEmpty ?? false,
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: TagoLight.textBold,
                  ),
                ),
              ),
            ),

            //FILTER SCREEN
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    '${TextConstant.searchResultsFor}"${widget.controller.searchProductController.text}"',
                    style: context.theme.textTheme.bodySmall,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      TextConstant.filters,
                      style: context.theme.textTheme.titleSmall,
                    ),
                    const Icon(
                      Icons.tune_rounded,
                      size: 16,
                    ),
                  ].rowInPadding(6),
                ),
              ],
            ).padSymmetric(horizontal: 20, vertical: 15),

            // the product cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 0.6,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  widget.product!.length, (index) => Text(widget.product![index].name!)
                  // productCard(
                  //   productModel: widget.product![index],
                  //   context: context,
                  //   addToCartBTN: () {
                  //     ref.read(cartNotifierProvider.notifier).addToCartMethod(
                  //       map: {
                  //         ProductTypeEnums.productId.name: widget.product![index].id.toString(),
                  //         ProductTypeEnums.quantity.name: '1',
                  //       },
                  //     );
                  //     ref.invalidate(getCartListProvider(false));
                  //   },
                  // ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

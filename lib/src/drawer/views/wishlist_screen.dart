import 'package:tago/app.dart';

class WishListScreen extends ConsumerWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishList = ref.watch(fetchWishListProvider);
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
          icon: const Icon(Icons.shopping_cart_outlined),
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
                    var wishList = data[index];

                    return wishlistWidget(
                      context: context,
                      isPriceCancelled: false,
                      productsModel: wishList,
                    );
                  }),
                );

                // const Text('data');
              },
              error: (error, _) => Center(
                    child: Text(error.toString()),
                  ),
              loading: () => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )),
          // wishlistWidget(
          //   context: context,
          //   isPriceCancelled: false,
          //   images: drinkImages[2],
          // ),
          // wishlistWidget(
          //   context: context,
          //   isPriceCancelled: true,
          //   images: drinkImages[3],
          // ),
          // wishlistWidget(
          //   context: context,
          //   isPriceCancelled: true,
          //   images: drinkImages[5],
          // ),
        ],
      ),
    );
  }

  Container wishlistWidget({
    required BuildContext context,
    bool? isPriceCancelled,
    required ProductsModel productsModel,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cachedNetworkImageWidget(
            imgUrl: productsModel.productImages?.first['image']['url'],
            height: 100,
          ),
          Expanded(
            child: ListTile(
              minLeadingWidth: 80,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              isThreeLine: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productsModel.name ?? '',
                    // 'Fanta Drink - 50cl Pet x 12',
                    style: context.theme.textTheme.bodySmall,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      productsModel.savedPerc != null
                          ? Text(
                              productsModel.amount.toString().toCommaPrices(),
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(decoration: TextDecoration.lineThrough),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        productsModel.originalAmount == null
                            ? productsModel.amount.toString().toCommaPrices()
                            : productsModel.originalAmount.toString().toCommaPrices(),
                        style: context.theme.textTheme.titleMedium,
                      ),
                    ].rowInPadding(5),
                  ),
                ].columnInPadding(10),
              ),

              //subtitle
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star_rate_rounded,
                        color: TagoDark.orange,
                      ),
                      Text(
                        '3.5',
                        style: context.theme.textTheme.bodyLarge,
                      ),
                      Text(
                        '(123)',
                        style: context.theme.textTheme.bodyMedium,
                      ),
                    ].rowInPadding(5),
                  ),
                  isPriceCancelled == true
                      ? ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(25),
                            visualDensity: VisualDensity.compact,
                          ),
                          child: Text(
                            TextConstant.addtocart,
                            style: context.theme.textTheme.bodyLarge?.copyWith(
                              color: TagoDark.scaffoldBackgroundColor,
                            ),
                          ),
                        )
                      : Row(
                          // mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            addMinusBTN(
                              context: context,
                              isMinus: true,
                              onTap: () {},
                            ),
                            Text(
                              '2',
                              style: context.theme.textTheme.titleLarge,
                            ),
                            addMinusBTN(
                              context: context,
                              isMinus: false,
                              onTap: () {},
                            ),
                          ].rowInPadding(15),
                        )
                  // .debugBorder()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:tago/app.dart';

class TagScreen extends ConsumerStatefulWidget {
  final int tagId;
  final String appBarTitle;
  final String imageUrl;
  const TagScreen({
    super.key,
    required this.imageUrl,
    required this.appBarTitle,
    required this.tagId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TagScreenState();
}

class _TagScreenState extends ConsumerState<TagScreen> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = ref.watch(getProductsByTagProvider(widget.tagId.toString()));

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.appBarTitle,
              ),
              GestureDetector(
                  onTap: () => push(context, SearchScreen()),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search_outlined,
                    ),
                  )),
            ],
          ),
          actions: [
            IconButton(
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
            )
          ],
        ),
        body: Container(
          color: TagoDark.scaffoldBackgroundColor,
          child: ListView(children: [
            SizedBox(
              height: 200,
              child: cachedNetworkImageWidget(
                height: 200,
                width: double.infinity,
                isProgressIndicator: false,
                imgUrl: widget.imageUrl,
              ),

              // CachedNetworkImage(
              //   imageUrl: widget.imageUrl,
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              //   height: 200,
              // ),
            ),
            productsProvider
                .when(
                    data: (products) {
                      if (products.isEmpty) {
                        return const Center(
                          child: Text(
                            TextConstant.sorryNoProductsInCategory,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          products.length,
                          (index) {
                            var quantity = cartQuantityFromName(products[index]);

                            return ProductCard(
                              productModel: products[index],
                              // context: context,
                              // ref: ref,
                              // quantity: quantity ?? 1,
                              // setState: () => setState(() {}),

                              // addToCartBTN: () {
                              //   ref
                              //       .read(cartNotifierProvider.notifier)
                              //       .addToCartMethod(
                              //     map: {
                              //       ProductTypeEnums.productId.name:
                              //           products[index].id.toString(),
                              //       ProductTypeEnums.quantity.name: '1',
                              //     },
                              //   );
                              // },
                              // // onDecrementBTN: () {},
                              // onIncrementBTN: () {},
                            );
                          },
                        ),
                      );
                    },
                    error: (error, _) => Center(
                          child: Text(error.toString()),
                        ),
                    loading: () => tagScreenCardLoader(context: context))
                .padAll(10)
          ]),
        ));
  }
}

import 'package:tago/app.dart';

class SingleProductPage extends ConsumerStatefulWidget {
  const SingleProductPage({
    super.key,
    required this.appBarTitle,
    required this.image,
  });
  final String appBarTitle, image;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SingleProductPageState();
}

class _SingleProductPageState extends ConsumerState<SingleProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: widget.appBarTitle,
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
                return Container(
                    child: Column(
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
                        '${TextConstant.items} (2)',
                        style: context.theme.textTheme.bodyLarge,
                      ),
                    ),
                    myCartListTile(context, ref),
                    myCartListTile(context, ref),
                    myCartListTile(context, ref),
                    SizedBox(
                      width: context.sizeWidth(1),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('${TextConstant.checkout} (N34,000)'),
                      ),
                    ).padOnly(top: 30),
                    TextButton(
                        onPressed: () {},
                        child: const Text(TextConstant.continueShopping))
                  ],
                ).padAll(20));
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
                  child: Image.asset(
                    widget.image,
                    filterQuality: FilterQuality.high,
                    width: context.sizeWidth(1),
                    fit: BoxFit.fill,
                  ),
                ),
                singlePageProductListTile(context)
                    .padSymmetric(horizontal: 10, vertical: 5),
                // ValueListenableBuilder(
                //   valueListenable: ref.watch(valueNotifierProvider),
                //   builder: (context, value, child) {
                //     return Row(
                //       mainAxisSize: MainAxisSize.max,
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         addMinusBTN(
                //           context: context,
                //           isMinus: true,
                //           onTap: () {
                //             if (value > 1) {
                //               ref.read(valueNotifierProvider).value--;
                //             }
                //           },
                //         ),
                //         Text(
                //           value.toString(),
                //           style: context.theme.textTheme.titleMedium,
                //         ),
                //         addMinusBTN(
                //           context: context,
                //           onTap: () {
                //             ref.read(valueNotifierProvider).value++;
                //           },
                //         ),
                //       ],
                //     );
                //   },
                // ),
                SizedBox(
                  width: context.sizeWidth(1),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(TextConstant.addtocart),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  label: const Text(TextConstant.saved),
                )
              ],
            ),
          ),

          //
          ListTile(
            title: const Text(
              TextConstant.itemsDetails,
            ),
            subtitle: Text(
              'The most delicate moment requires impeccable precision. At CallToInspiration we know perfectly well that this step is crucial, which is why we have collected all the examples to ensure that the purchase is like a work of art! Get inspired!',
              style: context.theme.textTheme.bodyMedium?.copyWith(height: 1.7),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        TextConstant.weight,
                        style: context.theme.textTheme.bodyLarge,
                      ),
                      const Text('1')
                    ],
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 0.1),
                  )),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${TextConstant.ratingandReviews}(9)',
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

                ratingsCard(context),
                ratingsCard(context),
              ],
            ),
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
              itemCount: drinkImages.length - 3,
              shrinkWrap: false,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: context.sizeWidth(0.35),
                  child: itemsNearYouCard(
                    index: index,
                    context: context,
                    image: drinkImages[index],
                    onTap: () {
                      navBarPush(
                        context: context,
                        screen: SingleProductPage(
                          appBarTitle: drinkTitle[index],
                          image: drinkImages[index],
                        ),
                        withNavBar: false,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Column singlePageProductListTile(BuildContext context) {
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
            Text(
              widget.appBarTitle,
              style: context.theme.textTheme.labelMedium,
            ),
            Container(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: TagoDark.orange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'save 20%',
                style: context.theme.textTheme.labelLarge?.copyWith(
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),

        //subtitle
        Text(
          'N20,000',
          style: context.theme.textTheme.titleMedium,
        ),

        Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.star,
                color: TagoDark.orange,
              ),
              Text('3.5')
            ].rowInPadding(5))
      ],
    );
  }
}

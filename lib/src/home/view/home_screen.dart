import 'package:tago/app.dart';
import 'package:tago/src/home/loaders/category_card_loaders.dart';
import 'package:tago/src/widgets/shortcut_widget.dart';

final carouselSliderProvider = Provider<CarouselController>((ref) {
  return CarouselController();
});
final currentCarouselIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _controller = ScrollController();
  bool showSearchAddressWidget = true;

  @override
  void initState() {
    super.initState();

    // Add a listener to the ScrollController
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.offset <= 0 && !showSearchAddressWidget) {
      setState(() {
        showSearchAddressWidget = true;
      });
    } else if (_controller.offset > 0 && showSearchAddressWidget) {
      setState(() {
        showSearchAddressWidget = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesGroup = ref.watch(fetchCategoriesProvider);
    final cartList = ref.watch(getCartListProvider(false)).valueOrNull;
    final accountInfo = ref.watch(getAccountInfoProvider);
    // log(HiveHelper().getData(HiveKeys.token.keys));
    return Scaffold(
      appBar: homescreenAppbar(
          context: context,
          isBadgeVisible: cartList?.isNotEmpty ?? false,
          showSearchIcon: showSearchAddressWidget),
      body: ListView(
        controller: _controller,
        children: [
          showSearchAddressWidget
              ? searchBoxAndAddressWidget(context, accountInfo)
              : const SizedBox(),

          Container(
            padding:
                const EdgeInsets.only(right: 18, left: 18, bottom: 10, top: 10),
            child: Column(
              children: [
                // ORDER status
                homeScreenOrderStatusWidget(context: context, ref: ref)
                    .padOnly(top: 10, bottom: 25),

                //! HOT DEALS CATEGORY
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      '🔥',
                      textScaleFactor: 2,
                    ).padOnly(right: 5),
                    Text(
                      TextConstant.hotdeals,
                      style: context.theme.textTheme.titleLarge,
                    )
                  ],
                ),
                categoriesGroup.when(
                  data: (data) {
                    return Column(
                      children: [
                        CarouselSlider(
                          items:
                              hotDealsCarouselWidgetList(context, data!.deals),
                          carouselController: ref.watch(carouselSliderProvider),
                          options: CarouselOptions(
                              autoPlay: true,
                              // aspectRatio: 12 / 9,
                              enlargeCenterPage: false,
                              viewportFraction: 0.99,
                              enlargeFactor: 0,
                              onPageChanged: (index, reason) {
                                ref
                                    .read(currentCarouselIndexProvider.notifier)
                                    .update((state) => index);
                              }),
                        ).padOnly(bottom: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            data.deals.length,
                            (index) => GestureDetector(
                              onTap: () => ref
                                  .read(carouselSliderProvider)
                                  .animateToPage(index),
                              child: Container(
                                width: 6.0,
                                height: 6.0,
                                margin: const EdgeInsets.symmetric(
                                  // vertical: 8.0,
                                  horizontal: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? TagoLight.indicatorInactiveColor
                                          : TagoLight.indicatorActiveColor)
                                      .withOpacity(
                                    ref.watch(currentCarouselIndexProvider) ==
                                            index
                                        ? 0.9
                                        : 0.4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(
                      NetworkErrorEnums.checkYourNetwork.message,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  loading: () => categoryCardLoaders(context: context)
                      .padSymmetric(horizontal: 20),
                ),

                //! Categories section
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    TextConstant.categories,
                    style: context.theme.textTheme.titleLarge,
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      ref.read(bottomNavControllerProvider).jumpToTab(1);
                    },
                    child: const Text(TextConstant.seeall),
                  ),
                ),

                categoriesGroup.when(
                  data: (data) {
                    return GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      childAspectRatio: 0.67,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        8,
                        // growable: false,
                        (index) => GestureDetector(
                          onTap: () {
                            ref.read(categoryLabelProvider.notifier).update(
                                (state) => data.categories[index].label ?? '');
                            var subList = data.categories[index].subCategories;

                            push(
                              context,
                              FruitsAndVegetablesScreen(
                                subCategoriesList: subList!,
                                appBarTitle: data.categories[index].name ??
                                    'Product name',
                              ),
                            );
                          },
                          child: categoryCard(
                            context: context,
                            index: index,
                            width: context.sizeWidth(0.155),
                            height: 85,
                            categoriesModel: data!.categories[index],
                          ),
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(
                      NetworkErrorEnums.checkYourNetwork.message,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  loading: () => categoryCardLoaders(context: context)
                      .padSymmetric(horizontal: 20),
                ),

                // shortcut
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextConstant.shortcuts,
                      style: context.theme.textTheme.titleLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        shortcutWidget(
                            context: context,
                            icon: Icons.favorite_outline,
                            name: 'Favorites'),
                        shortcutWidget(
                            context: context,
                            icon: Icons.star_border_outlined,
                            name: 'best Sellers'),
                        shortcutWidget(
                            context: context,
                            icon: Icons.receipt_outlined,
                            name: 'Past Orders'),
                        shortcutWidget(
                            context: context,
                            icon: Icons.message_outlined,
                            name: 'Support'),
                      ],
                    ).padOnly(top: 10)
                  ],
                ).padOnly(top: 20, bottom: 25),
              ],
            ),
          ),
          categoriesGroup
              .when(
                data: (data) {
                  if (data!.showcaseProductTag == null) {
                    return const SizedBox();
                  }
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          data.showcaseProductTag!.name,
                          style: context.theme.textTheme.titleLarge,
                        ),
                        trailing: TextButton(
                          onPressed: () {},
                          child: const Text(TextConstant.seeall),
                        ),
                      ).padOnly(bottom: 10),
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: data.showcaseProductTag!.imageUrl!,
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 320,
                          ),
                          SizedBox(
                            height: 320,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                  left: 170.0, top: 10, bottom: 10),
                              itemCount:
                                  data.showcaseProductTag!.products!.length,
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return productCard(
                                  productModel:
                                      data.showcaseProductTag!.products![index],
                                  context: context,
                                  addToCartBTN: () {
                                    ref
                                        .read(cartNotifierProvider.notifier)
                                        .addToCartMethod(
                                      map: {
                                        ProductTypeEnums.productId.name: data
                                            .showcaseProductTag!
                                            .products![index]
                                            .id
                                            .toString(),
                                        ProductTypeEnums.quantity.name: '1',
                                      },
                                    );
                                  },
                                ).padOnly(left: 10);
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    NetworkErrorEnums.checkYourNetwork.message,
                    textAlign: TextAlign.center,
                  ),
                ),
                loading: () => categoryCardLoaders(context: context)
                    .padSymmetric(horizontal: 20),
              )
              .padOnly(bottom: 20),
          ListTile(
            title: Text(
              TextConstant.recentlyViewed,
              style: context.theme.textTheme.titleLarge,
            ),
            trailing: TextButton(
              onPressed: () {},
              child: const Text(
                TextConstant.seeall,
              ),
            ),
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              itemCount: drinkImages.length - 3,
              shrinkWrap: false,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: context.sizeWidth(0.35),
                  child: itemsNearYouCard(
                    // index: index,
                    context: context,
                    image: noImagePlaceholderHttp,
                  ),
                );
              },
            ),
          ).padOnly(bottom: 20),
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstant.didNotFind,
                  style: context.theme.textTheme.titleMedium!
                      .copyWith(fontSize: 40, color: Colors.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  TextConstant.suggestSomething,
                  style: context.theme.textTheme.titleSmall!
                      .copyWith(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    TextConstant.suggest,
                    style: context.theme.textTheme.titleMedium!
                        .copyWith(fontSize: 14, color: TagoLight.orange),
                  ),
                )
              ],
            ),
          ).padOnly(bottom: 100),

          // authTextFieldWithError(
          //   controller: TextEditingController(),
          //   context: context,
          //   isError: false,
          //   readOnly: true,
          //   onTap: () {
          //     push(context, SearchScreen());
          //   },
          //   filled: true,
          //   hintText: TextConstant.whatdoYouNeedToday,
          //   prefixIcon: const Icon(Icons.search),
          //   fillColor: TagoLight.textFieldFilledColor,
          // ).padSymmetric(horizontal: context.sizeWidth(0.07), vertical: 15),

          // //! home screen order status
          // homeScreenOrderStatusWidget(context: context, ref: ref),

          // deliver to
          // homeScreenAddressWidget(context, accountInfo),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     const Text(
          //       '🔥',
          //       textScaleFactor: 2,
          //     ).padOnly(right: 5),
          //     Text(
          //       TextConstant.hotdeals,
          //       style: context.theme.textTheme.titleLarge,
          //     )
          //   ],
          // ).padOnly(top: 1, left: 20, bottom: 5),
          // //! HOT DEALS CATEGORY
          // Column(
          //   children: [
          //     CarouselSlider(
          //       items: carouselWidgetList(context),
          //       carouselController: ref.watch(carouselSliderProvider),
          //       options: CarouselOptions(
          //           autoPlay: true,
          //           aspectRatio: 20 / 9,
          //           enlargeCenterPage: false,
          //           viewportFraction: 0.99,
          //           enlargeFactor: 0,
          //           onPageChanged: (index, reason) {
          //             ref
          //                 .read(currentCarouselIndexProvider.notifier)
          //                 .update((state) => index);
          //           }),
          //     ),
          //     // .padOnly(bottom: 10),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: List.generate(
          //         carouselWidgetList(context).length,
          //         (index) => GestureDetector(
          //           onTap: () =>
          //               ref.read(carouselSliderProvider).animateToPage(index),
          //           child: Container(
          //             width: 6.0,
          //             height: 6.0,
          //             margin: const EdgeInsets.symmetric(
          //               // vertical: 8.0,
          //               horizontal: 4.0,
          //             ),
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: (Theme.of(context).brightness == Brightness.dark
          //                       ? TagoLight.indicatorInactiveColor
          //                       : TagoLight.indicatorActiveColor)
          //                   .withOpacity(
          //                 ref.watch(currentCarouselIndexProvider) == index
          //                     ? 0.9
          //                     : 0.4,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ).padSymmetric(vertical: 7),

          //! Categories section
//           ListTile(
//             title: const Text(
//               TextConstant.categories,
//             ),
//             trailing: TextButton(
//               onPressed: () {
//                 ref.read(bottomNavControllerProvider).jumpToTab(1);
//               },
//               child: const Text(TextConstant.seeall),
//             ),
//           ),

//           categories
//               .when(
//                 data: (data) {
//                   return GridView.count(
//                     crossAxisCount: 5,
//                     shrinkWrap: true,
//                     childAspectRatio: 0.65,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     children: List.generate(
//                       data.length - (data.length - 9),
//                       // data.length,
//                       growable: true,
//                       (index) => GestureDetector(
//                         onTap: () {
//                           ref
//                               .read(categoryLabelProvider.notifier)
//                               .update((state) => data[index].label ?? '');
//                           var subList = data[index].subCategories;

//                           push(
//                             context,
//                             FruitsAndVegetablesScreen(
//                               subCategoriesList: subList!,
//                               appBarTitle: data[index].name ?? 'Product name',
//                             ),
//                           );
//                         },
//                         child: categoryCard(
//                           context: context,
//                           index: index,
//                           width: context.sizeWidth(0.155),
//                           height: 70,
//                           categoriesModel: data[index],
//                         ),
//                       ),
//                     ),
//                   );
//                   //  Wrap(
//                   //   runSpacing: 20,
//                   //   spacing: 10,
//                   //   alignment: WrapAlignment.start,
//                   //   // runAlignment: WrapAlignment.start,
//                   //   crossAxisAlignment: WrapCrossAlignment.start,
//                   //   children: List.generate(
//                   //     data.length - (data.length - 9),
//                   //     // data.length,
//                   //     growable: true,
//                   //     (index) => GestureDetector(
//                   //       onTap: () {
//                   //         ref
//                   //             .read(categoryLabelProvider.notifier)
//                   //             .update((state) => data[index].label ?? '');
//                   //         var subList = data[index].subCategories;

//                   //         push(
//                   //           context,
//                   //           FruitsAndVegetablesScreen(
//                   //             subCategoriesList: subList!,
//                   //             appBarTitle: data[index].name ?? 'Product name',
//                   //           ),
//                   //         );
//                   //       },
//                   //       child: categoryCard(
//                   //         context: context,
//                   //         index: index,
//                   //         width: context.sizeWidth(0.155),
//                   //         height: 70,
//                   //         categoriesModel: data[index],
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ).padSymmetric(horizontal: 15);
//                 },
//                 error: (error, stackTrace) => Center(
//                   child: Text(
//                     NetworkErrorEnums.checkYourNetwork.message,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 loading: () => categoryCardLoaders(context: context)
//                     .padSymmetric(horizontal: 20),
//               )
//               .padOnly(left: 5),
// //items near you
//           ListTile(
//             title: const Text(
//               TextConstant.itemsNearYou,
//             ),
//             trailing: TextButton(
//               onPressed: () {
//                 log(ref.watch(categoryLabelProvider));
//               },
//               child: const Text(TextConstant.seeall),
//             ),
//           ),

//           SizedBox(
//             height: 220,
//             child: ListView.builder(
//               itemCount: drinkImages.length - 3,
//               shrinkWrap: false,
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return SizedBox(
//                   width: context.sizeWidth(0.35),
//                   child: itemsNearYouCard(
//                     context: context,
//                     image: noImagePlaceholderHttp,
//                     onTap: () {
//                       // navBarPush(
//                       //   context: context,
//                       //   screen: SingleProductPage(
//                       //    productsModel: ProductsModel(),
//                       //   ),
//                       //   withNavBar: false,
//                       // );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           ListTile(
//             title: const Text(
//               TextConstant.recentlyViewed,
//             ),
//             trailing: TextButton(
//               onPressed: () {},
//               child: const Text(TextConstant.seeall),
//             ),
//           ),
//           SizedBox(
//             height: 220,
//             child: ListView.builder(
//               itemCount: drinkImages.length - 3,
//               shrinkWrap: false,
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return SizedBox(
//                   width: context.sizeWidth(0.35),
//                   child: itemsNearYouCard(
//                     // index: index,
//                     context: context,
//                     image: noImagePlaceholderHttp,
//                   ),
//                 );
//               },
//             ),
//           ),
        ],
      ),
    );
  }

  Column homeScreenAddressWidget(
      BuildContext context, AsyncValue<AccountModel> accountInfo) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.directions_bike_sharp,
              color: TagoLight.textHint,
            ).padOnly(right: 8),
            Text(
              TextConstant.deliverto,
              style: context.theme.textTheme.bodyLarge,
            )
          ],
        ).padOnly(left: 20, top: 10),
        ListTile(
          minLeadingWidth: 1,
          dense: true,
          shape: const Border(bottom: BorderSide(width: 0.1)),
          leading: const Icon(
            Icons.location_on,
            color: TagoDark.primaryColor,
          ),
          trailing: TextButton(
            onPressed: () {
              HiveHelper().deleteData(HiveKeys.token.keys);
            },
            child: const Text(TextConstant.edit),
          ),
          title: Text(
            '${accountInfo.valueOrNull?.address?.apartmentNumber}, ${accountInfo.valueOrNull?.address!.streetAddress}',
            style: context.theme.textTheme.titleLarge?.copyWith(
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}

searchBoxAndAddressWidget(
    BuildContext context, AsyncValue<AccountModel> accountInfo) {
  var address = accountInfo.valueOrNull?.address;

  return Container(
    color: TagoDark.primaryColor,
    padding: const EdgeInsets.only(right: 18, left: 18, bottom: 10, top: 10),
    child: Column(
      children: [
        // search box
        GestureDetector(
          child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: TagoLight.textFieldBorder,
                    ),
                  ),
                  Text(
                    TextConstant.whatdoYouNeedToday,
                    style: AppTextStyle.hintTextStyleLight,
                  ),
                ],
              )),
          onTap: () {
            push(context, SearchScreen());
          },
        ),
        // deliver to
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            Text(
              address != null
                  ? '${address.apartmentNumber}, ${address.streetAddress}'
                  : 'Add your address',
              style: context.theme.textTheme.titleLarge?.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ],
        )
      ],
    ),
  );
}

import 'package:hive_flutter/hive_flutter.dart';
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
        showSearchIcon: showSearchAddressWidget,
      ),
      body: ListView(
        controller: _controller,
        children: [
          showSearchAddressWidget
              ? searchBoxAndAddressWidget(context, accountInfo)
              : const SizedBox(),
          Container(
            padding: const EdgeInsets.only(right: 18, left: 18, bottom: 10, top: 10),
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
                          items: hotDealsCarouselWidgetList(context, data!.deals),
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
                              onTap: () => ref.read(carouselSliderProvider).animateToPage(index),
                              child: Container(
                                width: 6.0,
                                height: 6.0,
                                margin: const EdgeInsets.symmetric(
                                  // vertical: 8.0,
                                  horizontal: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness == Brightness.dark
                                          ? TagoLight.indicatorInactiveColor
                                          : TagoLight.indicatorActiveColor)
                                      .withOpacity(
                                    ref.watch(currentCarouselIndexProvider) == index ? 0.9 : 0.4,
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
                  loading: () => hotDealsLoaders(context: context).padSymmetric(horizontal: 1),
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
                            ref
                                .read(categoryLabelProvider.notifier)
                                .update((state) => data.categories[index].label ?? '');
                            var subList = data.categories[index].subCategories;

                            push(
                              context,
                              FruitsAndVegetablesScreen(
                                subCategoriesList: subList!,
                                appBarTitle: data.categories[index].name ?? 'Product name',
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
                  loading: () => categoryCardLoaders(context: context).padSymmetric(horizontal: 20),
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
                            context: context, icon: Icons.favorite_outline, name: 'Favorites'),
                        shortcutWidget(
                            context: context,
                            icon: Icons.star_border_outlined,
                            name: 'best Sellers'),
                        shortcutWidget(
                            context: context, icon: Icons.receipt_outlined, name: 'Past Orders'),
                        shortcutWidget(
                            context: context, icon: Icons.message_outlined, name: 'Support'),
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
                              padding: const EdgeInsets.only(left: 170.0, top: 10, bottom: 10),
                              itemCount: data.showcaseProductTag!.products!.length,
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return productCard(
                                  productModel: data.showcaseProductTag!.products![index],
                                  context: context,
                                  addToCartBTN: () {
                                    ref.read(cartNotifierProvider.notifier).addToCartMethod(
                                      map: {
                                        ProductTypeEnums.productId.name:
                                            data.showcaseProductTag!.products![index].id.toString(),
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
                loading: () => categoryCardLoaders(context: context).padSymmetric(horizontal: 20),
              )
              .padOnly(bottom: 20),
          // ListTile(
          //   title: const Text(
          //     TextConstant.itemsNearYou,
          //   ),
          //   trailing: TextButton(
          //     onPressed: () {
          //       log(ref.watch(categoryLabelProvider));
          //     },
          //     child: const Text(TextConstant.seeall),
          //   ),
          // ),
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
                              padding: const EdgeInsets.only(left: 170.0, top: 10, bottom: 10),
                              itemCount: data.showcaseProductTag!.products!.length,
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return productCard(
                                  productModel: data.showcaseProductTag!.products![index],
                                  context: context,
                                  addToCartBTN: () {
                                    ref.read(cartNotifierProvider.notifier).addToCartMethod(
                                      map: {
                                        ProductTypeEnums.productId.name:
                                            data.showcaseProductTag!.products![index].id.toString(),
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
                loading: () => categoryCardLoaders(context: context).padSymmetric(horizontal: 20),
              )
              .padOnly(bottom: 20),
          // ListTile(
          //   title: Text(
          //     TextConstant.recentlyViewed,
          //     style: context.theme.textTheme.titleLarge,
          //   ),
          //   trailing: TextButton(
          //     onPressed: () {},
          //     child: const Text(
          //       TextConstant.seeall,
          //     ),
          //   ),
          // ),

          ValueListenableBuilder(
            valueListenable: HiveHelper().getRecentlyViewedListenable(),
            builder: (BuildContext context, Box box, Widget? child) {
              if (HiveHelper().getRecentlyViewed() != null) {
                final myData =
                    HiveHelper().getRecentlyViewed(defaultValue: []) as List<ProductsModel>;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        TextConstant.recentlyViewed,
                        style: context.theme.textTheme.titleLarge,
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          HiveHelper().clearBoxRecent();
                        },
                        child: const Text(
                          TextConstant.seeall,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        itemCount: myData.length,
                        shrinkWrap: false,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var product = myData[index];

                          return SizedBox(
                            width: context.sizeWidth(0.35),
                            child: itemsNearYouCard(
                              onTap: () {
                                // HiveHelper().clearBoxRecent();
                                navBarPush(
                                  context: context,
                                  screen: SingleProductPage(
                                    id: product.id!,
                                    productsModel: product,
                                  ),
                                  withNavBar: false,
                                );
                              },
                              products: product,
                              context: context,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
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
        ],
      ),
    );
  }

  Column homeScreenAddressWidget(BuildContext context, AsyncValue<AccountModel> accountInfo) {
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
  BuildContext context,
  AsyncValue<AccountModel> accountInfo,
) {
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
        GestureDetector(
          onTap: () {
            if (address == null) {
              push(context, const AddNewAddressScreen());
            } else {
              HiveHelper().saveData(HiveKeys.fromCheckout.keys, HiveKeys.fromCheckout.keys);

              push(context, const AddressBookScreen());
            }
          },
          child: Row(
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
          ),
        )
      ],
    ),
  );
}

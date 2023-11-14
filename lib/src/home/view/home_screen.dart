import 'package:tago/app.dart';
import 'package:tago/src/home/loaders/category_card_loaders.dart';
import 'package:tago/src/home/view/tag_screen.dart';
import 'package:tago/src/widgets/shortcut_widget.dart';

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
    // final cartList = ref.watch(getCartListProvider(false)).valueOrNull;
    // final accountInfo = ref.watch(getAccountInfoProvider);
    final accountInfo = ref.watch(getAccountInfoProvider);
    final orderList = ref
        .watch(orderListProvider(false))
        .valueOrNull
        ?.where((element) => element.status! > 0)
        .toList();
    // log(HiveHelper().getData(HiveKeys.token.keys).toString());

    // final accountInfo = ref.watch(getAccountAddressProvider).valueOrNull;
    // inspect(orderList);
    // log('categories by group: ${categoriesGroup.valueOrNull}');
    return Scaffold(
      appBar: homescreenAppbar(
        context: context,
        isBadgeVisible: checkCartBoxLength()?.isNotEmpty ?? false,
        showSearchIcon: showSearchAddressWidget,
      ),
      // drawer: const FaIcon(FontAwesomeIcons.circleUser),
      body: ListView(
        controller: _controller,
        children: [
          showSearchAddressWidget
              ? searchBoxAndAddressWidget(context, accountInfo.value)
              : const SizedBox(),
          Container(
            padding: const EdgeInsets.only(
              right: 18,
              left: 18,
              bottom: 10,
              top: 10,
            ),
            child: Column(
              children: [
                // ORDER status

                orderList?.isEmpty == true
                    ? const SizedBox.shrink()
                    : homeScreenOrderStatusWidget(
                        context: context,
                        ref: ref,
                        orderModel: orderList?[0] ?? const OrderListModel(),
                      ).padOnly(top: 10, bottom: 25),

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
                  loading: () => categoryCardLoaders(context: context, index: 8),
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
                          name: TextConstant.favorites.toTitleCase(),
                          onTap: () {
                            push(context, const WishListScreen());
                          },
                        ),
                        shortcutWidget(
                          context: context,
                          icon: Icons.star_border_outlined,
                          name: TextConstant.bestSellers.toTitleCase(),
                          onTap: () {
                            // push(context, const TagScreen(imageUrl: imageUrl, appBarTitle: appBarTitle, tagId: tagId));
                          },
                        ),
                        shortcutWidget(
                          context: context,
                          icon: Icons.receipt_outlined,
                          name: TextConstant.pastOrders.toTitleCase(),
                          onTap: () {
                            ref.read(bottomNavControllerProvider).jumpToTab(2);
                            ref
                                .read(initialIndexOrdersScreenProvider.notifier)
                                .update((state) => 1);
                          },
                        ),
                        shortcutWidget(
                          context: context,
                          icon: Icons.message_outlined,
                          name: TextConstant.support.toTitleCase(),
                          onTap: () {},
                        ),
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
                  var productTagModel = data.showcaseProductTag;
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          productTagModel!.name,
                          style: context.theme.textTheme.titleLarge,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            // log('is here pressed');

                            push(
                              context,
                              TagScreen(
                                tagId: productTagModel.id,
                                appBarTitle: productTagModel.name,
                                imageUrl:
                                    productTagModel.previewImageUrl ?? productTagModel.imageUrl!,
                              ),
                            );
                          },
                          child: const Text(TextConstant.seeall),
                        ),
                      ).padOnly(bottom: 10),
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: productTagModel.imageUrl!,
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 320,
                          ),
                          SizedBox(
                            height: 320,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 170.0, top: 10, bottom: 10),
                              itemCount: data.showcaseProductTag!.products!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context1, index) {
                                var productModel = data.showcaseProductTag!.products![index];
                                var quantity = cartQuantityFromName(productModel);
                                // var cartIndex = cartIndexFromID(productModel);

                                return productCard(
                                  productModel: productModel,
                                  context: context1,
                                  quantity: quantity ?? 1,
                                  ref: ref,
                                  setState: () => setState(() {}),
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

          //! RECENTLY VIEWED

          ValueListenableBuilder(
            valueListenable: HiveHelper().getRecentlyViewedListenable(),
            builder: (BuildContext context, Box<ProductsModel> box, Widget? child) {
              // if (HiveHelper().getRecentlyViewed() != null) {
              List<ProductsModel> products = box.values.toList();

              if (box.isNotEmpty) {
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
                          TextConstant.clear,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        itemCount: box.length,
                        shrinkWrap: false,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          products.sort((a, b) => b.date!.compareTo(a.date!));

                          return SizedBox(
                            width: context.sizeWidth(0.35),
                            child: itemsNearYouCard(
                              onTap: () {
                                HiveHelper().clearBoxRecent();
                                navBarPush(
                                  context: context,
                                  screen: SingleProductPage(
                                    id: products[index].id!,
                                    productsModel: products[index],
                                  ),
                                  withNavBar: false,
                                );
                              },
                              products: products[index],
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
                GestureDetector(
                  onTap: () {
                    //!   push to a suggest screen
                    navBarPush(
                      context: context,
                      screen: SuggestProductScreen(
                        categoriesGroupModel: categoriesGroup.valueOrNull,
                      ),
                      withNavBar: false,
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      TextConstant.suggest,
                      style: context.theme.textTheme.titleMedium!
                          .copyWith(fontSize: 14, color: TagoLight.orange),
                    ).padAll(10),
                  ),
                )
              ],
            ),
          ).padOnly(bottom: 20),
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
  AccountModel? accountInfo,
) {
  var address = accountInfo;

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
              Expanded(
                child: Text(
                  address != null
                      ? '${address.address?.apartmentNumber}, ${address.address?.streetAddress}, ${address.address?.city}'
                      : 'Add your address',
                  style: context.theme.textTheme.titleLarge?.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                  ),
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

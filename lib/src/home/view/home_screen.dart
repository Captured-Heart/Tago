import 'package:tago/app.dart';
import 'package:tago/src/home/loaders/category_card_loaders.dart';

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
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(fetchCategoriesProvider);
    final cartList = ref.watch(getCartListProvider(false)).valueOrNull;
    final accountInfo = ref.watch(getAccountInfoProvider);
    // log(HiveHelper().getData(HiveKeys.token.keys));
    return Scaffold(
      appBar: homescreenAppbar(
        context: context,
        isBadgeVisible: cartList?.isNotEmpty ?? false,
      ),
      body: ListView(
        controller: scrollController,
        children: [
          authTextFieldWithError(
            controller: TextEditingController(),
            context: context,
            isError: false,
            readOnly: true,
            onTap: () {
              push(context, SearchScreen());
            },
            filled: true,
            hintText: TextConstant.whatdoYouNeedToday,
            prefixIcon: const Icon(Icons.search),
            fillColor: TagoLight.textFieldFilledColor,
          ).padSymmetric(horizontal: context.sizeWidth(0.07), vertical: 15),

          //! home screen order status
          // homeScreenOrderStatusWidget(context: context, ref: ref),

//deliver to
          // homeScreenAddressWidget(context, accountInfo),
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
          ).padOnly(top: 1, left: 20, bottom: 5),
          //! HOT DEALS CATEGORY
          Column(
            children: [
              CarouselSlider(
                items: carouselWidgetList(context),
                carouselController: ref.watch(carouselSliderProvider),
                options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 20 / 9,
                    enlargeCenterPage: false,
                    viewportFraction: 0.99,
                    enlargeFactor: 0,
                    onPageChanged: (index, reason) {
                      ref.read(currentCarouselIndexProvider.notifier).update((state) => index);
                    }),
              ),
              // .padOnly(bottom: 10),
              carouselIndicator(
                context,
                carouselWidgetList(context).length,
                ref,
              ),
            ],
          ).padSymmetric(vertical: 7),

          //! Categories section
          ListTile(
            title: const Text(
              TextConstant.categories,
            ),
            trailing: TextButton(
              onPressed: () {
                ref.read(bottomNavControllerProvider).jumpToTab(1);
              },
              child: const Text(TextConstant.seeall),
            ),
          ),

          categories
              .when(
                data: (data) {
                  return GridView.count(
                    crossAxisCount: 5,
                    controller: scrollController,
                    shrinkWrap: true,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: List.generate(
                      data.length - (data.length - 9),
                      // data.length,
                      growable: true,
                      (index) => GestureDetector(
                        onTap: () {
                          ref
                              .read(categoryLabelProvider.notifier)
                              .update((state) => data[index].label ?? '');
                          var subList = data[index].subCategories;

                          push(
                            context,
                            FruitsAndVegetablesScreen(
                              subCategoriesList: subList!,
                              appBarTitle: data[index].name ?? 'Product name',
                            ),
                          );
                        },
                        child: categoryCard(
                          context: context,
                          index: index,
                          width: context.sizeWidth(0.155),
                          height: 70,
                          categoriesModel: data[index],
                        ),
                      ),
                    ),
                  );
                  //  Wrap(
                  //   runSpacing: 20,
                  //   spacing: 10,
                  //   alignment: WrapAlignment.start,
                  //   // runAlignment: WrapAlignment.start,
                  //   crossAxisAlignment: WrapCrossAlignment.start,
                  //   children: List.generate(
                  //     data.length - (data.length - 9),
                  //     // data.length,
                  //     growable: true,
                  //     (index) => GestureDetector(
                  //       onTap: () {
                  //         ref
                  //             .read(categoryLabelProvider.notifier)
                  //             .update((state) => data[index].label ?? '');
                  //         var subList = data[index].subCategories;

                  //         push(
                  //           context,
                  //           FruitsAndVegetablesScreen(
                  //             subCategoriesList: subList!,
                  //             appBarTitle: data[index].name ?? 'Product name',
                  //           ),
                  //         );
                  //       },
                  //       child: categoryCard(
                  //         context: context,
                  //         index: index,
                  //         width: context.sizeWidth(0.155),
                  //         height: 70,
                  //         categoriesModel: data[index],
                  //       ),
                  //     ),
                  //   ),
                  // ).padSymmetric(horizontal: 15);
                },
                error: (error, stackTrace) => Center(
                  child: Text(
                    NetworkErrorEnums.checkYourNetwork.message,
                    textAlign: TextAlign.center,
                  ),
                ),
                loading: () => categoryCardLoaders(context: context).padSymmetric(horizontal: 20),
              )
              .padOnly(left: 5),
//items near you
          ListTile(
            title: const Text(
              TextConstant.itemsNearYou,
            ),
            trailing: TextButton(
              onPressed: () {
                log(ref.watch(categoryLabelProvider));
              },
              child: const Text(TextConstant.seeall),
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
                    context: context,
                    image: noImagePlaceholderHttp,
                    onTap: () {
                      // navBarPush(
                      //   context: context,
                      //   screen: SingleProductPage(
                      //    productsModel: ProductsModel(),
                      //   ),
                      //   withNavBar: false,
                      // );
                    },
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: const Text(
              TextConstant.recentlyViewed,
            ),
            trailing: TextButton(
              onPressed: () {},
              child: const Text(TextConstant.seeall),
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
          ),
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

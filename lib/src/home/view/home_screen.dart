import 'package:carousel_slider/carousel_slider.dart';
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

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(fetchCategoriesProvider);
    List<Widget> carouselWidgetList = [
      hotDealsCarouselWidget(
        context: context,
        title: TextConstant.upto33percent,
        subTitle: TextConstant.getupto33percent,
        btnText: TextConstant.shopelectronics,
        onTapBtn: () {},
      ).padSymmetric(horizontal: 20),
      hotDealsCarouselWidget(
        context: context,
        title: TextConstant.tagoTreasureHunt,
        subTitle: TextConstant.findTheHiddenItems,
        onTapBtn: () {},
        btnText: TextConstant.startSearching,
      ).padSymmetric(horizontal: 20),
      hotDealsCarouselWidget(
        context: context,
        title: TextConstant.newArrivals,
        subTitle: TextConstant.checkOutHomeEssentials,
        onTapBtn: () {},
        btnText: TextConstant.browseHomeEssentials,
        isOrange: true,
      ).padSymmetric(horizontal: 20),
    ];
    return Scaffold(
      appBar: homescreenAppbar(context),
      body: ListView(
        children: [
          authTextFieldWithError(
            controller: TextEditingController(),
            context: context,
            isError: false,
            filled: true,
            hintText: TextConstant.whatdoYouNeedToday,
            prefixIcon: const Icon(Icons.search),
            fillColor: TagoLight.textFieldFilledColor,
          ).padSymmetric(horizontal: context.sizeWidth(0.07), vertical: 15),
          homeScreenOrderStatusWidget(context: context, ref: ref),

// deliver to
          Column(
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
                  onPressed: () {},
                  child: const Text(TextConstant.edit),
                ),
                title: Text(
                  '12, Adesemonye Avenue, Ikeja',
                  style: context.theme.textTheme.titleLarge?.copyWith(
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
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
          ).padOnly(top: 20, left: 20, bottom: 5),
          //! HOT DEALS CATEGORY
          Column(
            children: [
              CarouselSlider(
                items: carouselWidgetList,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  carouselWidgetList.length,
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

          categories.when(
            data: (data) {
              return Wrap(
                runSpacing: 20,
                spacing: 10,
                alignment: WrapAlignment.start,
                // runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
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
                      log(subList.toString());
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
              ).padSymmetric(horizontal: 15);
            },
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            loading: () => categoryCardLoaders(context: context),
          ),

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
                  child:
                      itemsNearYouCard(index: index, context: context, image: drinkImages[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget hotDealsCarouselWidget({
    required BuildContext context,
    required String title,
    required String subTitle,
    required String btnText,
    required VoidCallback onTapBtn,
    bool? isOrange = false,
  }) {
    return Column(
      children: [
        //  Row(
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
        // ).padSymmetric(vertical: 12),
        // container

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          width: context.sizeWidth(1),
          decoration: BoxDecoration(
              color: TagoLight.textFieldFilledColor, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.theme.textTheme.titleLarge,
                textAlign: TextAlign.left,
              ),
              Text(
                subTitle,
                style: context.theme.textTheme.titleLarge?.copyWith(
                  fontSize: 12,
                  fontWeight: AppFontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
              ElevatedButton(
                onPressed: onTapBtn,
                style: context.theme.elevatedButtonTheme.style?.copyWith(
                  fixedSize: const MaterialStatePropertyAll<Size>(
                    Size.fromHeight(38),
                  ),
                  backgroundColor: isOrange == true
                      ? const MaterialStatePropertyAll<Color>(TagoLight.orange)
                      : const MaterialStatePropertyAll<Color>(TagoLight.primaryColor),
                ),
                child: Text(btnText),
              )
            ].columnInPadding(15),
          ),
        )
      ],
    );
  }
}

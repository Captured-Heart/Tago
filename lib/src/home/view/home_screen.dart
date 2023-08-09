import 'package:tago/app.dart';
import 'package:tago/src/product/single_product_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Future<void> navigateToCategoryScreen(int index) {
      List screen = [
        FruitsAndVegetablesScreen(),
        OnBoardScreen(),
      ];
      return push(context, screen[index]);
    }

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
          Container(
            decoration: const BoxDecoration(
              color: TagoLight.textFieldFilledColor,
              border: Border(bottom: BorderSide(width: 0.1)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        TextConstant.activeOrderstatus,
                        style: context.theme.textTheme.bodyLarge,
                      ),
                    ),
                    Chip(
                        label: const Text(
                          TextConstant.pickedup,
                          style: TextStyle(color: TagoDark.primaryColor),
                        ),
                        shape: const ContinuousRectangleBorder(),
                        backgroundColor:
                            TagoLight.primaryColor.withOpacity(0.1))
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        TextConstant.remainingTime,
                        style: context.theme.textTheme.bodyLarge,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: TagoDark.primaryColor,
                        ).padOnly(right: 5),
                        Text(
                          '12 minutes away',
                          style: context.theme.textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    ref.read(scaffoldKeyProvider).currentState!.setState(() {
                      Scaffold.of(context).openDrawer();
                    });
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: const Text(
                    TextConstant.viewOrderdetails,
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          ),

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

//hot deals
          Column(
            children: [
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
              ).padSymmetric(vertical: 12),

              // container
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  width: context.sizeWidth(1),
                  decoration: BoxDecoration(
                      color: TagoLight.textFieldFilledColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextConstant.upto33percent,
                        style: context.theme.textTheme.titleLarge,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        TextConstant.getupto33percent,
                        style: context.theme.textTheme.titleLarge?.copyWith(
                          fontSize: 12,
                          fontWeight: AppFontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style:
                            context.theme.elevatedButtonTheme.style?.copyWith(
                          fixedSize: const MaterialStatePropertyAll<Size>(
                            Size.fromHeight(38),
                          ),
                        ),
                        child: const Text(TextConstant.shopelectronics),
                      )
                    ].columnInPadding(15),
                  ))
            ],
          ).padSymmetric(horizontal: 20),

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

          Wrap(
            runSpacing: 20,
            spacing: 10,
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: List.generate(
              categoriesFrame.length - 14,
              growable: true,
              (index) => GestureDetector(
                onTap: () => navigateToCategoryScreen(index),
                child: categoryCard(
                  context: context,
                  index: index,
                  width: context.sizeWidth(0.155),
                  height: 70,
                ),
              ),
            ),
          ).padSymmetric(horizontal: 15),

//items near you
          ListTile(
            title: const Text(
              TextConstant.itemsNearYou,
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
                  child: itemsNearYouCard(
                      index: index,
                      context: context,
                      image: drinkImages[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

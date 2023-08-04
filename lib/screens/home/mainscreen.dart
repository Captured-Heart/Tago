import 'dart:developer';

import 'package:tago/app.dart';
import 'package:tago/controllers/bottom_navbar_provider.dart';
import 'package:tago/controllers/scaffold_key.dart';
import 'package:tago/screens/account/my_account_screen.dart';
import 'package:tago/screens/home/home_screen.dart';
import 'package:tago/screens/screens.dart';
import 'package:tago/widgets/menu_drawer.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  // PreferredSizeWidget mainScreenAppBarWidget(screenIndex) {
  //   if (screenIndex == 0) {
  //     return homescreenAppbar(context);
  //   } else if (screenIndex == 1) {
  //     return categoriesAppbar();
  //   } else if (screenIndex == 2) {
  //     return ordersAppbar(context);
  //   } else if (screenIndex == 3) {
  //     return appBarWidget(
  //       context: context,
  //       title: TextConstant.myaccounts,
  //       isLeading: true,
  //       hasDrawer: true,
  //     );
  //   } else {
  //     return const PreferredSize(
  //       preferredSize: Size(20, 200),
  //       child: SizedBox.shrink(),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // int screenIndex = ref.watch(bottomNavBarIndexProvider);

    return Scaffold(
      key: ref.watch(scaffoldKeyProvider),
      drawer: tagoHomeDrawer(context),
      body: PersistentTabView(
        context,
        padding: const NavBarPadding.symmetric(horizontal: 10, vertical: 15),
        controller: ref.watch(bottomNavControllerProvider),
        navBarStyle: NavBarStyle.style6,
        hideNavigationBar: false,
        navBarHeight: kBottomNavigationBarHeight * 1.2,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        popAllScreensOnTapAnyTabs: true,
        confineInSafeArea: true,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        onItemSelected: (value) {
          log(value.toString());
          ref.read(bottomNavBarIndexProvider.notifier).update((state) => value);
        },
        items: navBarsItems(context: context),
        screens: const [
          HomeScreen(),
          AllCategoriesScreen(),
          OrdersScreen(),
          MyAccountScreen(),
        ],
        decoration: const NavBarDecoration(
          // borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.black,
          boxShadow: [
            BoxShadow(
              color: TagoDark.textLight,
              blurRadius: 1,
              spreadRadius: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}

List<PersistentBottomNavBarItem> navBarsItems({required BuildContext context}) {
  TextStyle itemTextStyle = context.theme.textTheme.bodyMedium!.copyWith(
      // fontWeight: AppFontWeight.medium,
      );
  return [
    PersistentBottomNavBarItem(
      textStyle: itemTextStyle,
      icon: const Icon(Icons.other_houses_outlined), //cottage_outlined
      title: TextConstant.home,
      iconSize: 24,
      activeColorPrimary: context.theme.primaryColor,
      inactiveColorPrimary: TagoDark.textHint,
    ),
    PersistentBottomNavBarItem(
      textStyle: itemTextStyle,
      icon: const Icon(Icons.grid_view),
      title: TextConstant.categories,
      iconSize: 24,
      activeColorPrimary: context.theme.primaryColor,
      inactiveColorPrimary: TagoDark.textHint,
    ),
    PersistentBottomNavBarItem(
      textStyle: itemTextStyle,
      icon: const FaIcon(
        FontAwesomeIcons.receipt,
      ),
      iconSize: 20,
      title: TextConstant.orders,
      activeColorPrimary: context.theme.primaryColor,
      inactiveColorPrimary: TagoDark.textHint,
    ),
    PersistentBottomNavBarItem(
      textStyle: itemTextStyle,
      icon: const FaIcon(FontAwesomeIcons.circleUser),
      title: TextConstant.accounts,
      iconSize: 20,
      activeColorPrimary: context.theme.primaryColor,
      inactiveColorPrimary: TagoDark.textHint,
    ),
  ];
}

import 'package:tago/app.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    ref.read(getAccountAddressProvider);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accountInfo = ref.watch(getAccountInfoProvider).valueOrNull;
    ref.watch(getCartListProvider(false));
    return Scaffold(
      key: ref.watch(scaffoldKeyProvider),
      drawer: tagoHomeDrawer(context, accountInfo),
      body: PersistentTabView(
        context,
        padding: const NavBarPadding.symmetric(horizontal: 10, vertical: 15),
        controller: ref.watch(bottomNavControllerProvider),
        navBarStyle: NavBarStyle.style6,
        hideNavigationBar: false,
        navBarHeight: kBottomNavigationBarHeight * 1.2,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        popAllScreensOnTapAnyTabs: false,
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
          // ReviewItemsScreen(),
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

import 'package:tago/app.dart';

// home screen appp bar
AppBar homescreenAppbar({
  required BuildContext context,
  required bool isBadgeVisible,
  required bool showSearchIcon,
}) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: TagoDark.primaryColor,
    leading: IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    ),
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          logoMediumLight,
          height: 40,
          width: 28,
        ).padOnly(right: 5),
        Text(
          TextConstant.title.toLowerCase(),
          style: context.theme.textTheme.titleLarge?.copyWith(
            fontSize: 20,
            fontFamily: TextConstant.fontFamilyBold,
            fontWeight: AppFontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 30,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: !showSearchIcon
                ? GestureDetector(
                    onTap: () => push(context, SearchScreen()),
                    child: const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox(),
          ),
        ),
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
          isLabelVisible: isBadgeVisible,
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}

//categories app bar
AppBar categoriesAppbar({
  required BuildContext context,
  required bool isBadgeVisible,
}) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(
        Icons.menu,
      ),
    ),
    title: const Text(
      TextConstant.allcategories,
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
          isLabelVisible: isBadgeVisible,
          child: const Icon(Icons.shopping_cart_outlined),
        ),
      )
    ],
  );
}

// Orders app bar
AppBar ordersAppbar({
  required BuildContext context,
  required bool isBadgeVisible,
  required TextEditingControllerClass controllerClass,
  required WidgetRef ref,
}) {
  return AppBar(
    toolbarHeight: kToolbarHeight * 1.5,
    leading: IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(
        Icons.menu,
      ),
    ),
    title: authTextFieldWithError(
      controller: controllerClass.searchProductController,
      context: context,
      isError: false,
      filled: true,
      hintText: TextConstant.serachYourOrders,
      prefixIcon: const Icon(Icons.search),
      fillColor: TagoLight.textFieldFilledColor,
      autoFocus: false,
      focusNode: controllerClass.ordersFocusNode,
      onChanged: (value) {
        ref.read(searchOrdersProvider.notifier).update((state) => value);
        // controllerClass.searchProductController.text = value;
      },
    ),
    actions: [
      IconButton(
        onPressed: () {
          controllerClass.ordersFocusNode.unfocus();
          navBarPush(
            context: context,
            screen: const MyCartScreen(),
            withNavBar: false,
          );
        },
        icon: Badge(
          backgroundColor: TagoLight.orange,
          smallSize: 10,
          isLabelVisible: isBadgeVisible,
          child: const Icon(Icons.shopping_cart_outlined),
        ),
      )
    ],
    bottom: TabBar(
      indicatorWeight: 4,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: TagoDark.primaryColor,
      labelStyle: context.theme.textTheme.titleMedium,
      unselectedLabelStyle: context.theme.textTheme.titleSmall,
      tabs: const [
        Tab(text: 'Active Orders'),
        Tab(text: 'Completed Orders'),
      ],
    ),
  );
}

//categories app bar
AppBar myAccountAppbar(BuildContext context) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(
        Icons.menu,
      ),
    ),
    title: const Text(
      TextConstant.myaccounts,
    ),
  );
}

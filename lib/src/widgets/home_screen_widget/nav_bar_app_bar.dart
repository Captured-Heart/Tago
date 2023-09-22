import 'package:tago/app.dart';

// home screen appp bar
AppBar homescreenAppbar({
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
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          logoMedium,
          height: 23,
          width: 23,
        ).padOnly(right: 5),
        Text(
          TextConstant.title.toLowerCase(),
          style: context.theme.textTheme.titleLarge?.copyWith(
            fontSize: 20,
            fontFamily: TextConstant.fontFamilyBold,
            fontWeight: AppFontWeight.w700,
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
          child: const Icon(Icons.shopping_cart_outlined),
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
}) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(
        Icons.menu,
      ),
    ),
    title: authTextFieldWithError(
      controller: TextEditingController(),
      context: context,
      isError: false,
      filled: true,
      hintText: TextConstant.searchInFruitsAndVeg,
      prefixIcon: const Icon(Icons.search),
      fillColor: TagoLight.textFieldFilledColor,
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
AppBar myAccountAppbar(context) {
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

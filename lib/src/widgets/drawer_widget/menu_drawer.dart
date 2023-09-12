import 'package:tago/app.dart';

Widget tagoHomeDrawer(BuildContext context) {
  return Drawer(
      child: SafeArea(
    minimum: EdgeInsets.only(
      top: context.sizeHeight(0.07),
    ),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            push(context, const MyAccountScreen());
          },
          child: Row(
                  children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(450),
              child: Image.asset(
                categoriesFrame[5],
                height: 50,
              ),
            ),
            Text(
              'Hello, Samuel ',
              style: context.theme.textTheme.titleLarge,
            ),
          ].rowInPadding(10))
              .padOnly(bottom: 20)
              .padSymmetric(horizontal: 20),
        ),
        drawerListTile(
          context: context,
          icons: FontAwesomeIcons.bell,
          title: TextConstant.notifications,
          onTap: () {
            pop(context);
            push(context, const NotificationScreen());
          },
        ),
        drawerListTile(
          context: context,
          icons: FontAwesomeIcons.heart,
          title: TextConstant.wishlist,
          onTap: () {
            pop(context);
            push(context, const WishListScreen());
          },
        ),
        drawerListTile(
          context: context,
          icons: FontAwesomeIcons.share,
          title: TextConstant.referandEarn,
          onTap: () {
            pop(context);
            push(context, const ReferAndEarn());
          },
        ),
        drawerListTile(
          context: context,
          icons: Icons.confirmation_num_outlined,
          title: TextConstant.vouchers,
          isMaterialIcon: true,
          onTap: () {
            pop(context);
            push(
              context,
              const MyVouchers(),
            );
          },
        ),
        drawerListTile(
            context: context,
            icons: Icons.logout,
            title: TextConstant.logOut,
            onTap: () {
              HiveHelper().deleteData(HiveKeys.token.keys).then((value) {
                pushReplacement(context, const SignInScreen());
              });
            },
            iconColor: TagoLight.textError,
            textStyle: context.theme.textTheme.titleSmall
                ?.copyWith(color: TagoLight.textError)),
      ],
    ),
  ));
  // .padOnly(bottom: kBottomNavigationBarHeight - 50);
}

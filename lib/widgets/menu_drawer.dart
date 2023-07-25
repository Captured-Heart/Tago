
import '../app.dart';

Drawer tagoHomeDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        minimum: EdgeInsets.only(
          top: context.sizeHeight(0.07),
        ),
        child: Column(
          children: [
            Row(
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
            drawerListTile(
              context: context,
              icons: FontAwesomeIcons.bell,
              title: TextConstant.notifications,
            ),
            drawerListTile(
              context: context,
              icons: FontAwesomeIcons.heart,
              title: TextConstant.wishlist,
            ),
            drawerListTile(
              context: context,
              icons: FontAwesomeIcons.share,
              title: TextConstant.referandEarn,
            ),
            drawerListTile(
              context: context,
              icons: Icons.confirmation_num_outlined,
              title: TextConstant.vouchers,
              isMaterialIcon: true,
            ),
            drawerListTile(
                context: context,
                icons: Icons.logout,
                title: TextConstant.logOut,
                iconColor: TagoLight.textError,
                textStyle: context.theme.textTheme.titleSmall
                    ?.copyWith(color: TagoLight.textError)),
          ],
        ),
      ),
    );
  }
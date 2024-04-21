import 'package:tago/app.dart';

class MyAccountScreen extends ConsumerWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountInfo = ref.watch(getAccountInfoProvider);

    var cardList = ref.watch(getCardsProvider);
    inspect(accountInfo);
    return Scaffold(
      drawer: tagoHomeDrawer(context, accountInfo.valueOrNull),
      appBar: myAccountAppbar(context, hideLeading: true),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Card(
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(5),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(8),
              //   side: const BorderSide(
              //     width: 0.05,
              //     strokeAlign: BorderSide.strokeAlignCenter,
              //   ),
              // ),
              leading: IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.circleUser,
                ),
              ),
              // ClipRRect(
              //   child: Image.asset(logoMedium),
              // ),
              title: Text('${accountInfo.valueOrNull?.fname} ${accountInfo.valueOrNull?.lname}'),
              subtitle: accountInfo.valueOrNull?.email?.isEmpty == true
                  ? null
                  : Text(accountInfo.valueOrNull?.phoneNumber ?? ''),
              trailing: TextButton(
                onPressed: () {
                  push(
                    context,
                    AddNewAddressScreen(
                      isEditMode: true,
                      addressModel: accountInfo.valueOrNull?.address,
                    ),
                  );
                },
                child: Text(
                  TextConstant.edit,
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    color: TagoDark.primaryColor,
                    fontFamily: TextConstant.fontFamilyNormal,
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              drawerListTile(
                context: context,
                icons: FontAwesomeIcons.bell,
                isMaterialIcon: true,
                materialIconSize: 22,
                iconColor: TagoDark.textBold,
                title: TextConstant.notifications,
                textStyle: context.theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
                onTap: () {
                  push(context, const NotificationScreen());
                },
              ),
              drawerListTile(
                context: context,
                icons: Icons.credit_card_outlined,
                isMaterialIcon: true,
                materialIconSize: 24,
                iconColor: TagoDark.textBold,
                title: TextConstant.paymentMethods,
                textStyle: context.theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
                onTap: () async {
                  var cards = cardList.valueOrNull;
                  if (cards!.isNotEmpty) {
                    push(
                        context,
                        PaymentsMethodScreen(
                          cards: cards,
                        ));
                  } else {
                    push(context, AddNewCardsScreen());
                  }
                },
              ),
              drawerListTile(
                context: context,
                icons: FontAwesomeIcons.locationDot,
                isMaterialIcon: true,
                materialIconSize: 20,
                iconColor: TagoDark.textBold,
                title: TextConstant.savedAddress,
                textStyle: context.theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
                onTap: () {
                  push(context, const AddressBookScreen());
                },
              ),
              drawerListTile(
                context: context,
                icons: FontAwesomeIcons.heart,
                iconColor: TagoDark.textBold,
                title: TextConstant.wishlist,
                textStyle: context.theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
                onTap: () {
                  push(context, const WishListScreen());
                },
              ),
              drawerListTile(
                context: context,
                icons: Icons.contact_page_outlined,
                isMaterialIcon: true,
                materialIconSize: 22,
                iconColor: TagoDark.textBold,
                title: TextConstant.editProfile,
                textStyle: context.theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
                onTap: () {
                  push(
                    context,
                    EditProfileScreen(
                      accountModel: accountInfo.valueOrNull,
                    ),
                  );
                },
              ),
              drawerListTile(
                context: context,
                icons: Icons.lock_open_rounded,
                isMaterialIcon: true,
                materialIconSize: 22,
                iconColor: TagoDark.textBold,
                title: TextConstant.changePassword,
                textStyle: context.theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
                onTap: () {
                  push(context, ChangePasswordScreen());
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
                  textStyle:
                      context.theme.textTheme.titleSmall?.copyWith(color: TagoLight.textError)),
            ],
          ).padOnly(top: 20)
        ],
      ),
    );
  }
}

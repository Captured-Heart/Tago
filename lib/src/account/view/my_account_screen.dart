import 'package:tago/app.dart';

class MyAccountScreen extends ConsumerWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountInfo = ref.watch(getAccountInfoProvider);
    return Scaffold(
      drawer: tagoHomeDrawer(context),
      appBar: myAccountAppbar(context),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                width: 0.05,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            leading: ClipRRect(
              child: Image.asset(logoMedium),
            ),
            title: Text('${accountInfo.value?.fname} ${accountInfo.value?.lname}'),
            // const Text('Samuel Adekanbi'),
            subtitle: Text(accountInfo.value?.email ?? 'you@example.com'),
            trailing: TextButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: TagoDark.primaryColor,
                  fontFamily: TextConstant.fontFamilyNormal,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                onTap: () {
                  push(context, const PaymentsMethodScreen());
                },
              ),
              drawerListTile(
                  context: context,
                  icons: FontAwesomeIcons.locationDot,
                  isMaterialIcon: true,
                  materialIconSize: 22,
                  iconColor: TagoDark.textBold,
                  title: TextConstant.savedAddress,
                  textStyle: context.theme.textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                  ),
                  onTap: () {
                    push(context, const AddressBookScreen());
                  }),
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
                  }),
              drawerListTile(
                context: context,
                icons: FontAwesomeIcons.circleQuestion,
                isMaterialIcon: true,
                materialIconSize: 22,
                iconColor: TagoDark.textBold,
                title: TextConstant.help,
                textStyle: context.theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ).padOnly(top: 20)
        ],
      ),
    );
  }
}

import 'package:tago/app.dart';
import 'package:tago/screens/account/payment_methods.dart';
import 'package:tago/widgets/menu_drawer.dart';

class MyAccountScreen extends ConsumerWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: tagoHomeDrawer(context),
      appBar: appBarWidget(
        context: context,
        title: TextConstant.myaccounts,
        isLeading: true,
        hasDrawer: true,
      ),
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
            title: const Text('Samuel Adekanbi'),
            subtitle: const Text('samuel@example.com'),
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
              ),
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
              ),
              drawerListTile(
                context: context,
                icons: FontAwesomeIcons.circleQuestion,
                isMaterialIcon: true,
                materialIconSize: 22,
                iconColor: TagoDark.textBold,
                title: TextConstant.paymentMethods,
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

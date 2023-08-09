import 'package:tago/app.dart';


class RiderAccountScreen extends ConsumerWidget {
  const RiderAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: tagoHomeDrawer(context),
      appBar: myAccountAppbar(context),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                width: 0.05,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            leading: Icon(
              FontAwesomeIcons.circleUser,
              color: TagoLight.textBold,
            ),
            title: const Text('Samuel Adekanbi'),
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

          ///
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              drawerListTile(
                context: context,
                icons: FontAwesomeIcons.listUl,
                isMaterialIcon: false,
                iconColor: TagoDark.textBold,
                title: TextConstant.metrics,
                textStyle: context.theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
                onTap: () {
                  push(context, const MetricsScreen());
                },
              ),
              drawerListTile(
                  context: context,
                  icons: FontAwesomeIcons.bell,
                  isMaterialIcon: false,
                  iconColor: TagoDark.textBold,
                  title: TextConstant.notifications,
                  textStyle: context.theme.textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                  ),
                  onTap: () {
                    push(context, const DeliveryRequestScreen());
                  }),
              drawerListTile(
                context: context,
                icons: FontAwesomeIcons.circleQuestion,
                isMaterialIcon: false,
                iconColor: TagoDark.textBold,
                title: TextConstant.help,
                onTap: () {
                  push(context, const NewDeliveryRequestScreen());
                },
                textStyle: context.theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
              ),
              ListTile(
                onTap: () {},
                shape: const Border(bottom: BorderSide(width: 0.1)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                minLeadingWidth: 1,
                leading: const RotatedBox(
                  quarterTurns: 2,
                  child: FaIcon(
                    FontAwesomeIcons.arrowRightFromBracket,
                    color: TagoLight.textError,
                    size: 22,
                  ),
                ),
                title: Text(
                  TextConstant.signOut,
                  style: context.theme.textTheme.titleSmall?.copyWith(
                    color: TagoLight.textError,
                  ),
                ),
              ),
            ],
          ).padOnly(top: 20)
        ],
      ),
    );
  }
}

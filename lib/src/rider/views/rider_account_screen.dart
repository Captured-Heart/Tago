import 'package:tago/app.dart';

class RiderAccountScreen extends ConsumerStatefulWidget {
  const RiderAccountScreen({super.key});

  @override
  ConsumerState<RiderAccountScreen> createState() => _RiderAccountScreenState();
}

class _RiderAccountScreenState extends ConsumerState<RiderAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final accountInfo = ref.watch(getAccountInfoProvider).valueOrNull;

    return Scaffold(
      key: ref.watch(scaffoldKeyProvider),
      drawer: tagoHomeDrawer(context, accountInfo),
      appBar: myAccountAppbar(context),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                width: 0.05,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            leading: const Icon(
              FontAwesomeIcons.circleUser,
              color: TagoLight.textBold,
            ),
            title: Text('${accountInfo?.fname} ${accountInfo?.lname}'),
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
                onTap: () {},
              ),
              drawerListTile(
                context: context,
                icons: FontAwesomeIcons.circleQuestion,
                isMaterialIcon: false,
                iconColor: TagoDark.textBold,
                title: TextConstant.help,
                onTap: () {
                  // push(context, const NewDeliveryRequestScreen());
                },
                textStyle: context.theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
              ),
              ListTile(
                onTap: () {
                  HiveHelper().deleteData(HiveKeys.token.keys).then((_) {
                    pushReplacement(context, const SignInScreen());
                  });
                },
                shape: const Border(bottom: BorderSide(width: 0.1)),
                contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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

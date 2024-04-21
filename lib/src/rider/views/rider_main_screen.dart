import 'package:tago/app.dart' hide Badge;
import 'package:badges/badges.dart';

final bottomNarBarIndexProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
  name: 'FOR BOTTOM NAV BAR',
);

class RiderMainScreen extends ConsumerStatefulWidget {
  const RiderMainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RiderMainScreenState();
}

class _RiderMainScreenState extends ConsumerState<RiderMainScreen> {
  @override
  void initState() {
    ref.read(getCurrentLocationProvider);
    // ref.read(deliveryRequestsProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accountInfo = ref.watch(getAccountInfoProvider).valueOrNull;
    final deliveryRequests = ref.watch(deliveryRequestsProvider).valueOrNull;

    final pendingDeliveryRequests =
        deliveryRequests?.where((e) => e.status == 0).toList().length ?? 0;

    log(pendingDeliveryRequests.toString());
    final currentIndex = ref.watch(bottomNarBarIndexProvider);
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 0) {
          return false;
        } else {
          ref.invalidate(bottomNarBarIndexProvider);
          return false;
        }
      },
      child: Scaffold(
        key: ref.watch(scaffoldKeyProvider),
        drawer: currentIndex > 0 ? tagoHomeDrawer(context, accountInfo) : null,
        appBar: currentIndex > 0 ? myAccountAppbar(context, hideLeading: true) : null,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Divider(
              thickness: 1.6,
              height: 2,
            ),
            BottomNavigationBar(
              landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
              currentIndex: currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.receipt).padOnly(top: 10),
                  label: TextConstant.orders,
                  tooltip: TextConstant.home,
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    position: BadgePosition.topEnd(top: 1, end: -12),
                    // badgeContent: Text(
                    //   '$pendingDeliveryRequests',
                    //   textScaleFactor: 0.9,
                    //   style: context.theme.textTheme.bodyLarge
                    //       ?.copyWith(color: TagoDark.scaffoldBackgroundColor),
                    // ),
                    badgeStyle: const BadgeStyle(padding: EdgeInsets.all(8)),
                    badgeAnimation: const BadgeAnimation.scale(loopAnimation: true),
                    showBadge:
                        //  true,
                        pendingDeliveryRequests > 0,
                    child: const Icon(
                      FontAwesomeIcons.circleUser,
                    ).padOnly(top: 10),
                  ),
                  label: TextConstant.accounts,
                  tooltip: TextConstant.accounts,
                ),
              ],
              onTap: (value) {
                ref.read(bottomNarBarIndexProvider.notifier).update((state) => value);
              },
              backgroundColor: context.theme.scaffoldBackgroundColor,
              elevation: 4,
              iconSize: 28,
              selectedLabelStyle: AppTextStyle.listTileTitleLight.copyWith(
                fontSize: 15,
                fontWeight: AppFontWeight.w500,
              ),
              unselectedLabelStyle: AppTextStyle.listTileSubtitleLight.copyWith(fontSize: 15),
              selectedItemColor: context.theme.primaryColor,
              unselectedItemColor: context.theme.textTheme.bodyMedium?.color?.withOpacity(0.4),
              type: BottomNavigationBarType.fixed,
            ),
          ],
        ),
        body: currentIndex > 0 ? const RiderAccountScreen() : const RiderHomeScreen(),
      ),
    );
  }
}

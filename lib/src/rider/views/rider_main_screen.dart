import 'package:tago/app.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accountInfo = ref.watch(getAccountInfoProvider).valueOrNull;

    final currentIndex = ref.watch(bottomNarBarIndexProvider);
    return Scaffold(
      key: ref.watch(scaffoldKeyProvider),
      drawer: currentIndex > 0 ? tagoHomeDrawer(context, accountInfo) : null,
      appBar: currentIndex > 0 ? myAccountAppbar(context) : null,
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
                icon: const Icon(
                  FontAwesomeIcons.circleUser,
                ).padOnly(top: 10),
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
    );
  }
}

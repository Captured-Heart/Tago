import 'package:tago/app.dart';
import 'package:tago/src/rider/views/rider_completed_order_screen.dart';

class RiderHomeScreen extends ConsumerStatefulWidget {
  const RiderHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends ConsumerState<RiderHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final accountInfo = ref.watch(getAccountInfoProvider);
    final deliveryRequests = ref.watch(deliveryRequestsProvider).valueOrNull;
    final deliveryRequestNumber = deliveryRequests?.where((e) => e.status == 1).toList().length;
    // log(deliveryRequests!.where((e) => e.status == 1).toList().toString());

    // log(orderList.toString());
    // log(deliveryRequests.toString());
    // log(HiveHelper().getData(HiveKeys.token.keys).toString());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: kToolbarHeight * 2.3,

            leading: const SizedBox.shrink(),
            flexibleSpace: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// title and leading icon
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: GestureDetector(
                          onTap: () {
                            push(context, const RiderAccountScreen());
                          },
                          child: const Icon(
                            FontAwesomeIcons.circleUser,
                            color: TagoLight.textBold,
                          ),
                        ),
                        title: Text('Hello, ${accountInfo.valueOrNull?.fname}'),
                        //
                        trailing: GestureDetector(
                          onTap: () {
                            push(context, const RiderAccountScreen());
                            log(accountInfo.valueOrNull?.id!.toString() ?? 'nothing');
                            // HiveHelper().deleteData(HiveKeys.token.keys);
                          },
                          child: const Icon(
                            Icons.notifications_none_outlined,
                            color: TagoLight.textBold,
                          ),
                        ),
                      ),

                      // how many orders
                      GestureDetector(
                        onTap: () {
                          push(context, const DeliveryRequestScreen());
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: TagoDark.primaryColor.withOpacity(0.1),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.receipt,
                                          color: TagoDark.primaryColor,
                                          size: 15,
                                        ),
                                        Text(
                                          '$deliveryRequestNumber',
                                          style: context.theme.textTheme.titleLarge?.copyWith(
                                            color: TagoDark.primaryColor,
                                            fontWeight: AppFontWeight.w500,
                                          ),
                                        )
                                      ].rowInPadding(5),
                                    ).padAll(5),
                                  ),
                                  Text(
                                    'You have completed $deliveryRequestNumber orders today',
                                    style: context.theme.textTheme.bodyMedium,
                                  ),
                                ].rowInPadding(10)),
                            const Icon(
                              Icons.arrow_forward_ios,
                              // size: 24
                            ),
                          ],
                        ),
                      ),
                    ].columnInPadding(10))
                .padOnly(top: kTextTabBarHeight * 1.2)
                .padSymmetric(horizontal: 20),

            // the tab bars
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
          ),
          body: const TabBarView(
            children: [
              //active order screen
              RiderActiveOrderScreen(),

              // completed section
              RiderCompletedOrderScreen()
            ],
          )

          //

          ),
    );
  }
}

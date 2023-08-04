import 'package:tago/app.dart';
import 'package:tago/utils/extensions/debug_frame.dart';

import '../../widgets/fruits_veggies_card.dart';

class RiderHomeScreen extends ConsumerStatefulWidget {
  const RiderHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RiderHomeScreenState();
}

class _RiderHomeScreenState extends ConsumerState<RiderHomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                        leading: const Icon(
                          FontAwesomeIcons.circleUser,
                          color: TagoLight.textBold,
                        ),
                        title: const Text('Hello, Fuad'),
                        //
                        trailing: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.notifications_none_outlined,
                            color: TagoLight.textBold,
                          ),
                        ),
                      ),

                      // how many orders
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        TagoDark.primaryColor.withOpacity(0.1),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.receipt,
                                        color: TagoDark.primaryColor,
                                        size: 15,
                                      ),
                                      Text(
                                        '0',
                                        style: context
                                            .theme.textTheme.titleLarge
                                            ?.copyWith(
                                          color: TagoDark.primaryColor,
                                          fontWeight: AppFontWeight.w500,
                                        ),
                                      )
                                    ].rowInPadding(5),
                                  ).padAll(5),
                                ),
                                Text(
                                  'You have completed 4 orders today',
                                  style: context.theme.textTheme.bodyMedium,
                                ),
                              ].rowInPadding(10)),
                          const Icon(
                            Icons.arrow_forward_ios,
                            // size: 24
                          ),
                        ],
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
          body: TabBarView(
            children: [
              ListView(
                children: [
                  riderOrdersListTile(
                    context: context,
                    orderStatus: OrderStatus.active,
                  ),
                  riderOrdersListTile(
                    context: context,
                    orderStatus: OrderStatus.cancelled,
                  ),
                ],
              ),

              // completed section
              ListView(
                children: [
                  riderOrdersListTile(
                    context: context,
                    orderStatus: OrderStatus.successful,
                  ),
                  riderOrdersListTile(
                    context: context,
                    orderStatus: OrderStatus.cancelled,
                  ),
                ],
              ),
            ],
          )

          //

          ),
    );
  }

  Container riderOrdersListTile({
    required BuildContext context,
    required Enum orderStatus,
  }) {
    getOrderStatusColor(Enum status) {
      if (status == OrderStatus.cancelled) {
        return TagoLight.textError;
      } else if (status == OrderStatus.processing) {
        return TagoLight.orange;
      } else {
        return TagoLight.primaryColor;
      }
    }

    getOrderStatusTitle(Enum status) {
      if (status == OrderStatus.cancelled) {
        return TextConstant.cancelled;
      } else if (status == OrderStatus.successful) {
        return TextConstant.successful;
      } else {
        return TextConstant.active;
      }
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            drinkImages[3],
            height: 100,
            width: 100,
            fit: BoxFit.fill,
          ),
          Expanded(
            child: ListTile(
              minLeadingWidth: 80,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              isThreeLine: true,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fanta Drink - 50cl Pet x 12',
                    style: context.theme.textTheme.bodySmall,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: getOrderStatusColor(orderStatus).withOpacity(0.1),
                    ),
                    child: Text(
                      getOrderStatusTitle(orderStatus),
                      style: context.theme.textTheme.bodyLarge?.copyWith(
                        color: getOrderStatusColor(orderStatus),
                      ),
                    ),
                  ),
                ].columnInPadding(10),
              ),

              //subtitle
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: context.sizeWidth(0.36),
                      child: Text(
                        '12 Adesemoye Avenue, Ikeja, Lagos  .   2km',
                        style: context.theme.textTheme.bodyMedium,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: TagoLight.orange.withOpacity(0.1),
                      ),
                      child: Text(
                        TextConstant.viewdetails,
                        style: context.theme.textTheme.bodyLarge?.copyWith(
                          color: TagoLight.orange,
                        ),
                      ),
                    ),
                    // .debugBorder()
                  ].columnInPadding(8)),
            ),
          ),
        ],
      ),
    );
  }
}

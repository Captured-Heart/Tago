import 'package:tago/app.dart';
import 'package:tago/widgets/menu_drawer.dart';

enum OrderStatus {
  intransit,
  processing,
  delivered,
  cancelled,
}

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: tagoHomeDrawer(context),
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
              ),
            );
          }),
          title: authTextFieldWithError(
            controller: TextEditingController(),
            context: context,
            isError: false,
            filled: true,
            hintText: TextConstant.searchInFruitsAndVeg,
            prefixIcon: const Icon(Icons.search),
            fillColor: TagoLight.textFieldFilledColor,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined),
            )
          ],
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
        body: TabBarView(children: [
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 30),
            children: [
              activeOrdersCard(
                imageAsset: logoLarge,
                context: context,
                orderStatus: OrderStatus.cancelled,
                imageIndex: 1,
              ),
              activeOrdersCard(
                imageAsset: logoLarge,
                context: context,
                orderStatus: OrderStatus.delivered,
                imageIndex: 0,
              ),
              activeOrdersCard(
                imageAsset: logoLarge,
                context: context,
                orderStatus: OrderStatus.processing,
                imageIndex: 4,
              ),
              // .debugBorder()
            ],
          ),

          //completed tab
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 30),
            children: [
              Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.receipt,
                          size: 84,
                          color: TagoLight.textHint,
                        ),
                        Text(
                          TextConstant.youHaveNoActiveOrders,
                          style: context.theme.textTheme.titleLarge?.copyWith(
                            fontWeight: AppFontWeight.w100,
                            fontFamily: TextConstant.fontFamilyLight,
                          ),
                        )
                      ].columnInPadding(20))
                  .padOnly(top: context.sizeHeight(0.1))
            ],
          ),
        ]),
      ),
    );
  }

  Container activeOrdersCard(
      {required BuildContext context,
      required String imageAsset,
      required Enum orderStatus,
      required int imageIndex}) {
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
      } else if (status == OrderStatus.processing) {
        return TextConstant.processing;
      } else if (status == OrderStatus.delivered) {
        return TextConstant.delivered;
      } else {
        return TextConstant.inTransit;
      }
    }

    return Container(
      // height: 250,
      padding: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.1),
        ),
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Image.asset(
            drinkImages[imageIndex],
            height: 95,
            width: 100,
            fit: BoxFit.fill,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  drinkTitle.values.map((e) => e).toList()[0],
                  style: context.theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: AppFontWeight.w300),
                ).padOnly(bottom: 5),
                Text('${TextConstant.orderID}: 7a0668z',
                    style: context.theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: AppFontWeight.w600)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: getOrderStatusColor(orderStatus).withOpacity(0.1),
                  ),
                  child: Text(
                    // TextConstant.inTransit,
                    getOrderStatusTitle(orderStatus),
                    style: context.theme.textTheme.bodyLarge
                        ?.copyWith(color: getOrderStatusColor(orderStatus)),
                  ),
                ),
              ].columnInPadding(8)),
        ],
      ),
    );
  }
}

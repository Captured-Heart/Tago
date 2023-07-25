import 'package:tago/app.dart';
import 'package:tago/utils/extensions/debug_frame.dart';
import 'package:tago/widgets/menu_drawer.dart';

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
              activeOrdersCard(imageAsset: logoLarge, context: context),
              // .debugBorder()
            ],
          ),
          Column(
            children: [],
          ),
        ]),
      ),
    );
  }

  Container activeOrdersCard({
    required BuildContext context,
    required String imageAsset,
  }) {
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
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Image.asset(
            drinkImages[4],
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
                      color: TagoDark.primaryColor.withOpacity(0.1)),
                  child: Text(
                    TextConstant.inTransit,
                    style: context.theme.textTheme.bodyLarge
                        ?.copyWith(color: TagoLight.primaryColor),
                  ),
                ),
              ].columnInPadding(8)),
        ],
      ),
    );
  }
}

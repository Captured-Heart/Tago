import 'package:tago/app.dart';

class RiderCompletedOrderScreen extends ConsumerStatefulWidget {
  const RiderCompletedOrderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RiderActiveOrderScreenState();
}

class _RiderActiveOrderScreenState extends ConsumerState<RiderCompletedOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderList = ref.watch(ridersOrderProvider);
    log(orderList.valueOrNull!.map((e) => e.status).toString());
    return ListView(
      children: [
        orderList.when(
          data: (data) {
            var completedList =
                data.where((element) => element.status == OrderStatus.delivered.status).toList();
            if (completedList.isNotEmpty) {
              return Column(
                children: List.generate(
                  completedList.length,
                  (index) {
                    var orderModel = data[index];
                    return GestureDetector(
                      onTap: () {},
                      child: activeOrdersCard(
                        context: context,
                        orderStatus: orderModel.status ?? 0,
                        orderModel: orderModel,
                        onViewDetails: () {
                          
                        },
                      ),
                    );
                  },
                ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
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
              ].columnInPadding(20),
            ).padOnly(top: 50);
          },
          error: (error, _) {
            return Text(error.toString());
          },
          loading: () => Column(
            children: List.generate(
              4,
              (index) => orderWidgetLoaders(context),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:tago/app.dart';
import 'package:tago/src/rider/views/active_delivery_screen.dart';

class RiderActiveOrderScreen extends ConsumerStatefulWidget {
  const RiderActiveOrderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RiderActiveOrderScreenState();
}

class _RiderActiveOrderScreenState
    extends ConsumerState<RiderActiveOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderList = ref.watch(ridersOrderProvider);

    return ListView(
      children: [
        orderList.when(
          data: (data) {
            if (data.isEmpty) {
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
            }
            return Column(
              children: List.generate(
                data.length,
                (index) {
                  var orderModel = data[index];
                  return GestureDetector(
                    onTap: () {},
                    child: activeOrdersCard(
                        context: context,
                        orderStatus: orderModel.status ?? 0,
                        orderModel: orderModel,
                        onViewDetails: () {
                          push(
                              context, ActiveDeliveryScreen(order: orderModel));
                        }),
                  );
                },
              ),
            );
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
    ).padOnly(top: 20);
  }
}

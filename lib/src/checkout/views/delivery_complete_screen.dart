import 'package:tago/app.dart';

class DeliveryCompleteScreen extends ConsumerWidget {
  const DeliveryCompleteScreen({
    super.key,
    required this.orderListModel,
  });
  final OrderListModel orderListModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: TagoLight.primaryColor,
                      size: 48,
                    ),
                    ListTile(
                      title: const Center(
                              child: Text(TextConstant.deliveryComplete))
                          .padOnly(bottom: 10),
                      subtitle: Center(
                        child: SizedBox(
                          width: context.sizeWidth(0.6),
                          child: const Text(
                            TextConstant.pleaseTakeAMoment,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    orderListModel.orderItems?.length ?? 1,
                    (index) => GestureDetector(
                      onTap: () {
                        navBarPush(
                          context: context,
                          screen: ReviewItemsScreen(),
                          withNavBar: false,
                        );
                      },
                      child: Container(
                        width: context.sizeWidth(0.9),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.1,
                              strokeAlign: BorderSide.strokeAlignCenter),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                orderListModel.name ?? '',
                                style: context.theme.textTheme.labelMedium,
                              ),
                              Text(
                                TextConstant.nairaSign +
                                    orderListModel.totalAmount
                                        .toString()
                                        .toCommaPrices(),
                                style: context.theme.textTheme.titleMedium,
                              ),
                            ].columnInPadding(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: context.sizeWidth(0.9),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(TextConstant.goToMyOrder),
                    ),
                  ),
                ),
                // const Spacer(),
              ].columnInPadding(40),
            ),
          ),
          // const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(TextConstant.goHome),
          ),
        ],
      ).padOnly(bottom: 30, top: 10),
    );
  }
}

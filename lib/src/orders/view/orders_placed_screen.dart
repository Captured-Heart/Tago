import 'package:tago/app.dart';

class OrderPlacedScreen extends ConsumerWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: TagoLight.primaryColor,
                size: 48,
              ),
              ListTile(
                title: const Center(child: Text(TextConstant.orderPlaced))
                    .padOnly(bottom: 10),
                subtitle: const Center(
                    child: Text(TextConstant.youWillReceiveAnEmail)),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: context.sizeWidth(0.9),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(TextConstant.seeOrderDetails),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(TextConstant.shopForAnotherItem),
              )
            ],
          ),
        ].columnInPadding(40),
      ),
    );
  }
}

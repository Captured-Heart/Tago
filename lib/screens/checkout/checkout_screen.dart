import 'package:tago/app.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.checkout,
        isLeading: true,
      ),
      body: ListView(
        children: [
          Text(
            TextConstant.deliveringTo,
            style: context.theme.textTheme.bodyLarge,
          ),
          
        ],
      ),
    );
  }
}

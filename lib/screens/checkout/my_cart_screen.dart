import 'package:tago/app.dart';
import 'package:tago/screens/checkout/checkout_screen.dart';
import 'package:tago/widgets/cart_list_tile.dart';

class MyCartScreen extends ConsumerStatefulWidget {
  const MyCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends ConsumerState<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    List cartList = List.generate(4, (index) => myCartListTile(context, ref));

    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.cart,
        isLeading: true,
      ),
      body: ListView(
        // itemExtent: 10,
        children: [
          // myCartListTile(context, ref),
          ...cartList,
          TextButton(
            onPressed: () {
              push(context, const CheckoutScreen());
            },
            child: Text('proceed to checkout screen'),
          )
        ],
      ),
    );
  }
}

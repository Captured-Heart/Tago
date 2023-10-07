// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:tago/app.dart';
import 'package:tago/src/account/controller/card_payment_async_notifier.dart';
import 'package:tago/src/account/model/domain/card_model.dart';

class PaymentsMethodScreen extends ConsumerStatefulWidget {
  bool isFromCheckout;
  final List<CardModel> cards;

  PaymentsMethodScreen(
      {required this.cards, this.isFromCheckout = false, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentsMethodScreenState();
}

class _PaymentsMethodScreenState extends ConsumerState<PaymentsMethodScreen> {
  num? amount;
  String? orderId;
  String? selectedCardId;

  PayWithCardAsyncNotifier? paymentNotifier;

  @override
  void initState() {
    super.initState();
    paymentNotifier = ref.read(payWithCardAsyncNotifierProvider.notifier);

    if (widget.isFromCheckout) {
      var data = HiveHelper().getData(HiveKeys.createOrder.keys)['data'];
      amount = data['totalAmount'];
      orderId = data['orderId'];
    }
  }

  getLogo(String brandName) {
    switch (brandName) {
      case "visa":
        return visacardLogo;
      case "master":
        return mastercardLogo;
      default:
        return mastercardLogo;
    }
  }

  void chargeCard() async {
    if (selectedCardId == null) {
      showScaffoldSnackBarMessage("Please select card to continue",
          isError: true);
      return;
    }
    Map<String, String> map = {"orderId": orderId!, "cardId": selectedCardId!};
    var paymentResponse = await paymentNotifier!
        .chargeCardPaymentAsyncMethod(map: map, context: context);
    if (paymentResponse == null) return;
    navBarPush(
      context: context,
      screen: const OrderPlacedScreen(),
      withNavBar: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(amount);
    return FullScreenLoader(
      isLoading: ref.watch(payWithCardAsyncNotifierProvider).isLoading,
      child: Scaffold(
        appBar: appBarWidget(
          context: context,
          title: widget.isFromCheckout
              ? TextConstant.selectCard
              : TextConstant.savedCards,
          isLeading: true,
        ),
        body: Column(
          children: [
            Column(
                children: List.generate(widget.cards.length, (index) {
              var card = widget.cards[index];
              return cardListTile(
                card: card,
              );
            })),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  push(
                      context,
                      AddNewCardsScreen(
                        isFromCheckout: widget.isFromCheckout,
                      ));
                },
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline),
                ),
                label: Text(widget.isFromCheckout
                    ? TextConstant.enterCardDetails
                    : TextConstant.addnewCard),
              ),
            ),
            const Spacer(),
            widget.isFromCheckout
                ? SizedBox(
                    width: context.sizeWidth(1),
                    child: ElevatedButton(
                      onPressed: () {
                        chargeCard();
                      },
                      child: Text("Pay ${TextConstant.nairaSign} $amount"),
                    ),
                  ).padOnly(bottom: 30)
                : SizedBox()
          ],
        ),
      ),
    );
  }

  ListTile cardListTile({required CardModel card}) {
    return ListTile(
      shape: const Border(bottom: BorderSide(width: 0.1)),
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      minLeadingWidth: 1,
      leading: Image.asset(
        getLogo(card.brand),
        height: 25,
        width: 35,
        fit: BoxFit.fill,
      ),
      title: Text(
        'Ending with ${card.last4}',
        style: context.theme.textTheme.titleSmall,
      ),
      trailing: widget.isFromCheckout
          ? Radio(
              value: card.id,
              groupValue: selectedCardId,
              onChanged: (value) {
                setState(() {
                  selectedCardId = value;
                });
              },
            )
          : null,
    );
  }
}

// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:tago/app.dart';
import 'package:tago/src/account/controller/card_payment_async_notifier.dart';
import 'package:tago/src/account/model/domain/text_editing_controllers.dart';

class AddNewCardsScreen extends ConsumerStatefulWidget {
  bool isFromCheckout;

  AddNewCardsScreen({this.isFromCheckout = false, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewCardsScreenState();
}

class _AddNewCardsScreenState extends ConsumerState<AddNewCardsScreen> {
  final PaymentTextEditingControllerClass controller =
      PaymentTextEditingControllerClass();

  var cardNumberFocusNode = FocusNode();
  var cvvFocusNode = FocusNode();

  num? amount;
  String? orderId;

  PayWithCardAsyncNotifier? paymentNotifier;

  final plugin = PaystackPlugin();
  @override
  void initState() {
    super.initState();
    // plugin.initialize(
    // publicKey: "pk_live_a68209cb5c4780bcd76ec9fa34c3bdcd61430ef3");
    plugin.initialize(
        publicKey: "pk_test_833030ac41495c2ad53fcbfa8b9fd4b572ac8db2");
  }

  void initiatePayment() async {
    String cardNum = controller.cardNumber.text.trim().replaceAll(' ', '');
    int expMonth = int.parse(controller.expiry.text.substring(0, 2));
    int expYear = int.parse(controller.expiry.text.substring(3, 5));

    PaymentCard card = PaymentCard(
      number: cardNum,
      cvc: controller.cvv.text,
      expiryMonth: expMonth,
      expiryYear: expYear,
    );

    if (!card.validNumber(cardNum)) {
      showScaffoldSnackBarMessage('Please enter a valid card number!',
          isError: true);
      return;
    }

    Map<String, String> map;
    if (widget.isFromCheckout) {
      map = {"orderId": orderId!};
    } else {
      var last4Digit = cardNum.substring(cardNum.length - 4);
      map = {"last4Digit": last4Digit};
    }

    var paymentResponse = await paymentNotifier!
        .initiatePaymentAsyncMethod(map: map, context: context);
    if (paymentResponse == null) return;

    var accessCode = paymentResponse['accessCode'];
    var reference = paymentResponse['reference'];

    var charge = Charge()
      ..accessCode = accessCode
      ..card = card;

    final checkoutResponse = await plugin.chargeCard(context, charge: charge);

    // Checking if the transaction is successful
    if (checkoutResponse.status) {
      var res = await paymentNotifier!
          .verifyPaymentAsyncMethod(reference: reference!, context: context);
      if (res != null) {
        if (widget.isFromCheckout) {
          navBarPush(
            context: context,
            screen: const OrderPlacedScreen(),
            withNavBar: false,
          );
        } else {
          pop(context);
          Future.delayed(const Duration(milliseconds: 200), () {
            ref.invalidate(getCardsProvider);
            showScaffoldSnackBarMessage("Card added successfully");
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    paymentNotifier = ref.read(payWithCardAsyncNotifierProvider.notifier);
    if (widget.isFromCheckout) {
      var data = HiveHelper().getData(HiveKeys.createOrder.keys)['data'];
      amount = data['totalAmount'];
      orderId = data['orderId'];
    }

    return FullScreenLoader(
      isLoading: ref.watch(payWithCardAsyncNotifierProvider).isLoading,
      child: Scaffold(
        appBar: appBarWidget(
          context: context,
          title: widget.isFromCheckout
              ? TextConstant.enterCardDetails
              : TextConstant.addnewCard,
          isLeading: true,
        ),
        body: Form(
          key: controller.addCardFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextConstant.cardNumber,
                      style: context.theme.textTheme.bodySmall,
                    ),
                    authTextFieldWithError(
                        controller: controller.cardNumber,
                        keyboardType: TextInputType.number,
                        focusNode: cardNumberFocusNode,
                        context: context,
                        isError: false,
                        validator: RequiredValidator(
                            errorText: "Card number is required"),
                        hintText: TextConstant.cardNumberHint,
                        style: AppTextStyle.listTileSubtitleLight
                            .copyWith(fontWeight: FontWeight.w700)),
                  ].columnInPadding(12)),
              Row(
                  children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextConstant.expiryDate,
                        style: context.theme.textTheme.bodySmall,
                      ),
                      authTextFieldWithError(
                          controller: controller.expiry,
                          keyboardType: TextInputType.number,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Expiry date is required"),
                            PatternValidator(
                              r'^(0[1-9]|1[0-2])/(2[3-9])$',
                              errorText: 'Please enter a valid date',
                            )
                          ]),
                          onChanged: (value) {
                            if (value.length == 5) {
                              FocusScope.of(context).requestFocus(cvvFocusNode);
                            }
                          },
                          style: AppTextStyle.listTileSubtitleLight
                              .copyWith(fontWeight: FontWeight.w700),
                          context: context,
                          isError: false,
                          hintText: TextConstant.mmAndyy),
                    ].columnInPadding(12),
                  ),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextConstant.cvv,
                          style: context.theme.textTheme.bodySmall,
                        ),
                        authTextFieldWithError(
                          controller: controller.cvv,
                          keyboardType: TextInputType.number,
                          focusNode: cvvFocusNode,
                          context: context,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Invalid CVV"),
                            PatternValidator(
                              r'^[0-9]{3}$',
                              errorText: "Invalid CVV",
                            )
                          ]),
                          hintText: '123',
                          isError: false,
                          style: AppTextStyle.listTileSubtitleLight
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ].columnInPadding(12)),
                )
              ].rowInPadding(20)),
              const Spacer(),
              SizedBox(
                width: context.sizeWidth(1),
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.addCardFormKey.currentState!.validate()) {
                      initiatePayment();
                    }
                  },
                  child: Text(amount != null
                      ? "Pay ${TextConstant.nairaSign} $amount"
                      : TextConstant.continue_),
                ),
              ).padOnly(bottom: 30)
            ],
          ).padAll(20),
        ),
      ),
    );
  }
}

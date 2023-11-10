import 'package:tago/app.dart';

final voucherCodeProvider = StateProvider<String>((ref) {
  return '';
});

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.cartModel,
    required this.totalAmount,
    required this.placeOrderModel,
  });

  final List<CartModel> cartModel;
  final List<PlaceOrderModel> placeOrderModel;

  final int? totalAmount;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  final ScrollController scrollController = ScrollController();
  bool isInstant = true;
  // payment method
  PaymentMethodsType paymentMethodType = PaymentMethodsType.notSelected;
  String scheduleForDate = "";
  String scheduleForTime = "";

  updatePaymentMethod(PaymentMethodsType paymentMethod) {
    setState(() {
      paymentMethodType = paymentMethod;
    });
  }

  updateScheduleForLaterDate(String date) {
    log(date);
    scheduleForDate = date;
  }

  updateScheduleForLaterTime(String time) {
    log(time);
    scheduleForTime = time;
  }

  @override
  Widget build(BuildContext context) {
    final accountInfo = ref.watch(getAccountInfoProvider);
    final code = ref.watch(voucherCodeProvider);
    var cardList = ref.watch(getCardsProvider);
    final address = ref.watch(getAccountAddressProvider).valueOrNull;

    final voucherCode = ref.watch(getVoucherStreamProvider(code));
    final deliveryFee =
        ref.watch(getDeliveryFeeProvider(widget.totalAmount ?? 0));
    var deliveryFeeValue = deliveryFee.valueOrNull ?? '0';
    var perc = ((int.parse('${voucherCode.valueOrNull?.amount ?? '0'}') /
                (widget.totalAmount ?? 0)) *
            100)
        .round();
    return FullScreenLoader(
      isLoading: ref.watch(checkoutNotifierProvider).isLoading,
      child: Scaffold(
        appBar: appBarWidget(
          context: context,
          title: TextConstant.checkout,
          isLeading: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          controller: scrollController,
          children: [
            //! delivering to
            checkoutDeliveryToWidget(
              context,
              address != null && address.isNotEmpty
                  ? accountInfo.valueOrNull?.address
                  : const AddressModel(),
            ),

            //! select delivery type
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstant.selectDeliveryType,
                  style: context.theme.textTheme.bodyLarge,
                ),
                deliveryTypeRowButtons(
                  context: context,
                  // setState: setState,
                  onTapScheduleDelivering: () {
                    setState(() {
                      isInstant = false;
                    });
                  },
                  onTapInstantSchedule: () {
                    setState(() {
                      isInstant = true;
                    });
                  },
                  isInstant: isInstant,
                ),
                const Divider(
                  thickness: 1,
                ),

                //DAY && TIMES WIDGET
                isInstant == true
                    ? const SizedBox.shrink()
                    : CheckOutDayAndTimesWidget(
                        updateScheduleForLaterDate: updateScheduleForLaterDate,
                        updateScheduleForLaterTime: updateScheduleForLaterTime,
                      ),
              ].columnInPadding(10),
            ).padOnly(top: 25),

            //!phone number
            checkoutPhoneNumberWidget(context, accountInfo),

            //!payment method

            checkoutPaymentMethodWidget(
                    context, updatePaymentMethod, paymentMethodType)
                .padOnly(top: 20),

            //! REVIEW ITEMS
            Text(
              TextConstant.reviewItems,
              style: context.theme.textTheme.titleLarge,
            ).padOnly(top: 20, bottom: 10),
            ListView.builder(
              itemCount: widget.cartModel.length,
              shrinkWrap: true,
              controller: scrollController,
              itemBuilder: (context, index) {
                return checkOutReviewItemsWidget(
                  context: context,
                  placeOrderModel: widget.placeOrderModel[index],
                );
              },
            ),

            //! delivery instructions and voucher code
            checkOutDeliveryInstructionsAndVoucherWidget(
              context: context,
              voucherCode: voucherCode,
              ref: ref,
              controller: controller,
            ),

            //! all items and total section
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  checkOutALLItemsRowWidget(
                    context: context,
                    leading: TextConstant.allitems,
                    trailing:
                        ' ${TextConstant.nairaSign} ${widget.totalAmount.toString().toCommaPrices()}',
                  ),
                  checkOutALLItemsRowWidget(
                    context: context,
                    leading: TextConstant.deliveryfee,
                    trailing: '₦${deliveryFeeValue.toCommaPrices()}',
                  ),
                  checkOutALLItemsRowWidget(
                    context: context,
                    leading: '${TextConstant.discount} ($perc%)',
                    trailing:
                        '- ${TextConstant.nairaSign}${voucherCode.valueOrNull?.amount ?? 0}',
                  ),
                  const Divider(thickness: 1),

                  // total
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextConstant.total,
                          style: context.theme.textTheme.labelMedium,
                        ),
                        Text(
                          TextConstant.nairaSign +
                              ((widget.totalAmount ?? 0) +
                                      int.parse(deliveryFeeValue) -
                                      int.parse(
                                        voucherCode.value?.amount == null
                                            ? '0'
                                            : voucherCode.value!.amount
                                                .toString(),
                                      ))
                                  .toString()
                                  .toCommaPrices(),
                          style: context.theme.textTheme.titleLarge?.copyWith(
                            color: TagoLight.primaryColor,
                          ),
                        ),
                      ].columnInPadding(5)),
                ].columnInPadding(10)),

            //! confirm order btn
            ElevatedButton(
              onPressed: () {
                // check if payment is selected
                if (paymentMethodType == PaymentMethodsType.notSelected) {
                  showScaffoldSnackBarMessage("Please select a payment method",
                      isError: true);
                  return;
                }

                // check if payment is selected
                if (!isInstant && scheduleForDate == "") {
                  showScaffoldSnackBarMessage(
                      "Schedule for later is not available",
                      isError: true);
                  return;
                }

                var items = [];
                for (var element in widget.placeOrderModel) {
                  items.add({
                    "productId": element.productId,
                    "quantity": element.quantity,
                  });
                }
                var checkModel = CheckoutModel(
                    addressId: accountInfo.valueOrNull?.address!.id,
                    deliveryType: DeliveryType.instant.name,
                    paymentMethod: paymentMethodType.message,
                    instructions: controller.instructionsController.text,
                    scheduleForDate: scheduleForDate,
                    scheduleForTime: scheduleForTime,
                    voucherCode: code,
                    items: jsonEncode(items));

                // filter order map
                var checkModelMap = checkModel.toJson();
                if (code.length != 7) {
                  checkModelMap.remove("voucherCode");
                }
                if (isInstant) {
                  checkModelMap.remove("scheduleForDate");
                  checkModelMap.remove("scheduleForTime");
                }

                ref.read(checkoutNotifierProvider.notifier).createAnOrderMethod(
                      map: checkModelMap,
                      onNavigation: () async {
                        HiveHelper().clearCartList();
                        if (paymentMethodType == PaymentMethodsType.cash) {
                          navBarPush(
                            context: context,
                            screen: const OrderPlacedScreen(),
                            withNavBar: false,
                          );
                        } else {
                          var cards = cardList.valueOrNull;
                          if (cards!.isNotEmpty) {
                            push(
                                context,
                                PaymentsMethodScreen(
                                  cards: cards,
                                  isFromCheckout: true,
                                ));
                          } else {
                            push(
                                context,
                                AddNewCardsScreen(
                                  isFromCheckout: true,
                                ));
                          }
                        }
                      },
                    );
              },
              child: const Text(TextConstant.confirmOrder),
            ).padOnly(top: 25, bottom: 45)
          ],
        ),
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    final accountInfo = ref.watch(getAccountInfoProvider);
    final code = ref.watch(voucherCodeProvider);
    final address = ref.watch(getAccountAddressProvider).valueOrNull;

    final voucherCode = ref.watch(getVoucherStreamProvider(code));
    final deliveryfee = ref.watch(getDeliveryFeeProvider(widget.totalAmount ?? 0));
    // log(" address : $accountInfo!.toString()");
    var deliveryFeeValue = deliveryfee.valueOrNull ?? '0';
    var perc =
        ((int.parse('${voucherCode.valueOrNull?.amount ?? '0'}') / (widget.totalAmount ?? 0)) * 100)
            .round();
    final addressId = ref.watch(addressIdProvider);
    // log(HiveHelper().getData(HiveKeys.addressId.keys).toString());
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
                  ? address[HiveHelper().getAddressIndex(HiveKeys.addressId.keys)]
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
                    log(isInstant.toString());
                  },
                  onTapInstantSchedule: () {
                    // HiveHelper().saveData(HiveKeys.addressId.keys, 0);
                    setState(() {
                      isInstant = true;
                    });
                    log(isInstant.toString());
                  },
                  isInstant: isInstant,
                ),
                const Divider(
                  thickness: 1,
                ),

                //DAY && TIMES WIDGET
                isInstant == true ? const SizedBox.shrink() : const CheckOutDayAndTimesWidget(),
              ].columnInPadding(10),
            ).padOnly(top: 25),

            //!phone number
            checkoutPhoneNumberWidget(context, accountInfo),

            //!payment method
            checkoutPaymentMethodWidget(context).padOnly(top: 20),

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
                    trailing: '- ${TextConstant.nairaSign}${voucherCode.valueOrNull?.amount ?? 0}',
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
                                            : voucherCode.value!.amount.toString(),
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
                if (controller.voucherController.text.isNotEmpty) {
                  log('token: ${HiveHelper().getData(HiveKeys.token.name)}');

                  var checkModel = CheckoutModel(
                    addressId: addressId,
                    deliveryType: DeliveryType.instant.name,
                    paymentMethod: PaymentMethodsType.cash.message,
                    instructions: controller.instructionsController.text,
                    voucherCode: controller.voucherController.text,
                    // scheduleForDate: '',
                    // '2023-08-23T00:00:00.000Z',
                    // DateTime.now().toIso8601String(),
                    // scheduleForTime: '',
                    items: jsonEncode(
                      widget.placeOrderModel,
                    ),
                  ).toJson();
                  log(checkModel.toString());
                  //
                  ref.read(checkoutNotifierProvider.notifier).createAnOrderMethod(
                        map: checkModel,
                        onNavigation: () {
                          navBarPush(
                            context: context,
                            screen: const OrderPlacedScreen(),
                            withNavBar: false,
                          );
                          ref.refresh(getCartListProvider(false));
                        },
                      );
                } else {
                  var checkModel = CheckoutModel(
                    addressId: addressId,
                    deliveryType: DeliveryType.instant.name,
                    paymentMethod: PaymentMethodsType.cash.message,
                    instructions: controller.instructionsController.text,
                    // scheduleForDate: '',
                    // '2023-08-23T00:00:00.000Z',
                    // DateTime.now().toIso8601String(),
                    // scheduleForTime: '',
                    items: jsonEncode(
                      widget.placeOrderModel,
                    ),
                  ).toJsonWithoutVocher();
                  log(checkModel.toString());
                  //
                  ref.read(checkoutNotifierProvider.notifier).createAnOrderMethod(
                        map: checkModel,
                        onNavigation: () {
                          navBarPush(
                            context: context,
                            screen: const OrderPlacedScreen(),
                            withNavBar: false,
                          );
                          ref.refresh(getCartListProvider(false));
                        },
                      );
                }
              },
              child: const Text(TextConstant.confirmOrder),
            ).padOnly(top: 25, bottom: 45)
          ],
        ),
      ),
    );
  }
}

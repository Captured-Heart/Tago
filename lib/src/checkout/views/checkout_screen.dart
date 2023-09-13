import 'package:tago/app.dart';

final voucherCodeProvider = StateProvider<String>((ref) {
  return '';
});

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.cartModel,
  });

  final CartModel cartModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final TextEditingControllerClass controller = TextEditingControllerClass();

  bool isInstant = true;

  @override
  Widget build(BuildContext context) {
    final accountInfo = ref.watch(getAccountInfoProvider);
    final code = ref.watch(voucherCodeProvider);

    final voucherCode = ref.watch(getVoucherStreamProvider(code));
    final deliveryfee = ref.watch(getDeliveryFeeProvider(widget.cartModel.product?.amount ?? 0));
    log(deliveryfee.toString());
    var perc =
        ((int.parse('${voucherCode.value?.amount ?? '0'}') / widget.cartModel.product!.amount!) *
                100)
            .round();
    final addressId = ref.watch(addressIdProvider);
    log(widget.cartModel.product!.id.toString());
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
          children: [
            //! delivering to
            checkoutDeliveryToWidget(context, accountInfo),

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
            checkOutReviewItemsWidget(
              context: context,
              cartModel: widget.cartModel,
            ).padOnly(top: 25),

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
                        ' ${TextConstant.nairaSign} ${widget.cartModel.product?.amount.toString().toCommaPrices() ?? '0'}',
                  ),
                  checkOutALLItemsRowWidget(
                    context: context,
                    leading: TextConstant.deliveryfee,
                    trailing: '₦${deliveryfee.value?.toCommaPrices() ?? 0}',
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
                              ((widget.cartModel.product?.amount ?? 0) +
                                      int.parse(deliveryfee.value ?? '0') -
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
                ref.read(checkoutNotifierProvider.notifier).createAnOrderMethod(
                      map: CheckoutModel(
                        addressId: addressId,
                        deliveryType: DeliveryType.instant.name,
                        paymentMethod: PaymentMethodsType.card.message,
                        instructions: controller.instructionsController.text,
                        voucherCode: controller.voucherController.text,
                        scheduleForDate: DateTime.now().toIso8601String(),
                        scheduleForTime: '',
                        items: [
                          PlaceOrderModel(
                            productId: widget.cartModel.product!.id.toString(),
                            quantity: '1',
                          ).toJson(),
                          // PlaceOrderModel(
                          //   productId: '8',
                          //   //  widget.cartModel.product!.id.toString(),
                          //   quantity: '1',
                          // ).toJson(),
                        ].toString(),
                      ).toJson(),
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

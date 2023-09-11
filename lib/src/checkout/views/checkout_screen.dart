import 'package:tago/app.dart';
import 'package:tago/config/utils/date_formatter.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  bool isInstant = true;
  int? selectedValue;
  int selectedIndex = 0;

  Color getColor(int selectedIndex, int index) {
    if (index == selectedIndex) {
      return TagoLight.primaryColor;
    } else {
      return TagoLight.textFieldBorder;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountInfo = ref.watch(getAccountInfoProvider);
    final availabileDate = ref.watch(getAvailabileDateProvider);
    final availabileTimes =
        ref.watch(getAvailabileTimesProvider(selectedIndex));
    final deliveryfee = ref
        .watch(getDeliveryFeeProvider([accountInfo.valueOrNull?.id, 102000]));
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.checkout,
        isLeading: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            TextConstant.deliveringTo,
            style: context.theme.textTheme.bodyLarge,
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            minLeadingWidth: 10,
            shape: const Border(bottom: BorderSide(width: 0.1)),
            leading: const Icon(
              Icons.location_on_outlined,
              color: TagoDark.primaryColor,
            ),
            title: Text(
              accountInfo.valueOrNull?.address?.streetAddress ??
                  TextConstant.noAddressFound,
              style: context.theme.textTheme.labelMedium,
            ),
            trailing: TextButton(
              style: TextButton.styleFrom(
                textStyle: AppTextStyle.textButtonW600_12,
              ),
              onPressed: () {
                if (accountInfo.valueOrNull?.address == null) {
                  push(context, const AddNewAddressScreen());
                } else {
                  push(context, const AddressBookScreen());
                }
              },
              child: Text(
                accountInfo.valueOrNull?.address == null
                    ? TextConstant.addAdress
                    : TextConstant.editAddress,
              ),
            ),
          ),

// select delivery type
          Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextConstant.selectDeliveryType,
                      style: context.theme.textTheme.bodyLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isInstant = true;
                            });
                            log(isInstant.toString());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isInstant == true
                                  ? TagoLight.orange
                                  : TagoLight.textFieldBorder,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Symbols.bolt_rounded,
                                  color: TagoLight.scaffoldBackgroundColor,
                                  size: 17,
                                ),
                                Text(
                                  TextConstant.instantDelivering,
                                  style: context.theme.textTheme.bodySmall
                                      ?.copyWith(
                                          color: TagoLight
                                              .scaffoldBackgroundColor),
                                ),
                              ].rowInPadding(5),
                            ),
                          ),
                        ),
                        //schedule for later
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isInstant = false;
                            });
                            log(isInstant.toString());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isInstant == true
                                  ? TagoLight.textFieldBorder
                                  : TagoLight.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Symbols.schedule,
                                  color: TagoLight.scaffoldBackgroundColor,
                                  size: 17,
                                ),
                                Text(
                                  '${TextConstant.deliveredIn} 15 ${TextConstant.minutes}',
                                  style: context.theme.textTheme.bodySmall
                                      ?.copyWith(
                                          color: TagoLight
                                              .scaffoldBackgroundColor),
                                ),
                              ].rowInPadding(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ].columnInPadding(10))
              .padOnly(top: 25),

          //DAY
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      TextConstant.day,
                      style: context.theme.textTheme.bodyLarge,
                    ),
                    availabileDate.when(
                      data: (data) {
                        return Row(
                          children: List.generate(
                              data.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      log(data[index].times![1].toString());
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(18),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: getColor(selectedIndex, index),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            getDayOfWeek(data[index].date!),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: AppTextStyle
                                                .hintTextStyleLight
                                                .copyWith(
                                              color: context.theme
                                                  .scaffoldBackgroundColor,
                                              fontWeight: AppFontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            dateFormatted2(data[index].date!),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: AppTextStyle
                                                .hintTextStyleLight
                                                .copyWith(
                                              color: context.theme
                                                  .scaffoldBackgroundColor,
                                              fontWeight: AppFontWeight.w700,
                                            ),
                                          ),
                                        ].columnInPadding(5),
                                      ),
                                    ),
                                  )).toList(),
                        );
                      },
                      error: (err, _) => const Text('No time available'),
                      loading: () => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  ].columnInPadding(10)),

//CHOOSE TIME
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TextConstant.chhoseTime,
                    style: context.theme.textTheme.bodyLarge,
                  ),
                  availabileTimes.when(
                    data: (data) {
                      return Column(
                        children: List.generate(
                          data.length,
                          (index) {
                            var timesModel = data[index];
                            return radioListTileWidget(
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value!;
                                });
                                log(value.toString());
                              },
                              title:
                                  '${timesModel.startTime}am to ${convertTo12Hrs(int.tryParse(timesModel.endTime!)!)}pm',
                              isAvailable: timesModel.status!,
                              selectedValue: selectedValue ?? 0,
                              value: index,
                            );
                          },
                        ).toList(),
                      );
                    },
                    error: (error, _) => Text(error.toString()),
                    loading: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ],
              )
            ].columnInPadding(10),
          ),

          //phone number
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextConstant.phoneno,
                style: context.theme.textTheme.bodyLarge,
              ),
              ListTile(
                minLeadingWidth: 25,
                shape: const Border(bottom: BorderSide(width: 0.1)),
                leading: const Icon(
                  Icons.call,
                  color: TagoLight.primaryColor,
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        accountInfo.valueOrNull?.phoneNumber.toString() ??
                            TextConstant.enterthePhoneno,
                        style: context.theme.textTheme.labelMedium,
                      ).padOnly(right: 5),
                    ),
                    accountInfo.valueOrNull?.phoneNumber != null
                        ? const SizedBox.shrink()
                        : Text(
                            TextConstant.notConfirmed,
                            style: context.theme.textTheme.titleMedium
                                ?.copyWith(
                                    color: TagoDark.orange,
                                    fontWeight: AppFontWeight.w500),
                          ),
                  ],
                ),
                trailing: accountInfo.valueOrNull?.phoneNumber != null
                    ? const SizedBox.shrink()
                    : TextButton(
                        style: TextButton.styleFrom(
                          textStyle: AppTextStyle.textButtonW600_12,
                        ),
                        onPressed: () {},
                        child: const Text(TextConstant.edit),
                      ),
              ),
            ],
          ),

          //!payment method
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextConstant.paymentMethod,
                style: context.theme.textTheme.bodyLarge,
              ),
              ListTile(
                shape: const Border(bottom: BorderSide(width: 0.1)),
                minLeadingWidth: 25,
                leading: const Icon(
                  FontAwesomeIcons.creditCard,
                  color: TagoLight.primaryColor,
                  size: 18,
                ),
                title: Text(
                  TextConstant.notselected,
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: AppFontWeight.w500,
                    color: TagoDark.textHint,
                  ),
                ),
                trailing: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: AppTextStyle.textButtonW600_12,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      // isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  TextConstant.choosePaymentMethod,
                                  style: context.theme.textTheme.titleLarge,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    pop(context);
                                  },
                                  child: const Icon(Icons.close),
                                )
                              ],
                            ).padOnly(bottom: 15, top: 5),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5),
                              minLeadingWidth: 25,
                              shape:
                                  const Border(bottom: BorderSide(width: 0.1)),
                              leading: const Icon(
                                FontAwesomeIcons.moneyBill,
                              ),
                              title: Text(
                                TextConstant.paywithcash,
                                style: context.theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: AppFontWeight.w500),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.chevron_right_rounded,
                                  size: 28,
                                ),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 25,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5),
                              shape:
                                  const Border(bottom: BorderSide(width: 0.1)),
                              leading: const Icon(
                                FontAwesomeIcons.ccMastercard,
                              ),
                              title: Text(
                                TextConstant.paywithcard,
                                style: context.theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: AppFontWeight.w500),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.chevron_right_rounded,
                                  size: 28,
                                ),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 25,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5),
                              leading: const Icon(
                                Icons.north_east_outlined,
                              ),
                              title: Text(
                                TextConstant.paywithbank,
                                style: context.theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: AppFontWeight.w500),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.chevron_right_rounded,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ).padAll(20);
                      },
                    );
                  },
                  child: const Text(TextConstant.choose),
                ),
              ),
            ],
          ).padOnly(top: 20),

//! REVIEW ITEMS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextConstant.reviewItems,
                style: context.theme.textTheme.titleLarge,
              ).padOnly(bottom: 5),
              Text(
                'Coca-cola drink - pack of 6 can',
                style: context.theme.textTheme.labelMedium?.copyWith(
                  fontWeight: AppFontWeight.w400,
                ),
              ),
              const Divider(thickness: 1),
              Text(
                'Coca-cola drink - pack of 6 can',
                style: context.theme.textTheme.labelMedium?.copyWith(
                  fontWeight: AppFontWeight.w400,
                ),
              ),
              Text(
                'N20,000',
                style: context.theme.textTheme.labelMedium,
              ),
              const Divider(thickness: 1)
            ].columnInPadding(8),
          ).padOnly(top: 25),

          // delivery instructions
          Column(
              children: [
            Row(
                children: [
              const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.insert_drive_file_outlined,
                  color: TagoLight.orange,
                ),
              ),
              Text(
                TextConstant.deliveryInstructionsOptional,
                style: context.theme.textTheme.titleLarge,
              ),
            ].rowInPadding(8)),
            authTextFieldWithError(
              controller: TextEditingController(),
              context: context,
              isError: false,
              hintText: TextConstant.writeaNoteHint,
            ).padSymmetric(horizontal: 30),
            const Divider(thickness: 1)
          ].columnInPadding(10)),

          // voucher code
          Column(
            children: [
              Row(
                  children: [
                const Icon(
                  Icons.confirmation_num_outlined,
                  color: TagoLight.orange,
                ),
                Text(
                  TextConstant.voucherCode,
                  style: context.theme.textTheme.titleLarge,
                ),
              ].rowInPadding(8)),
              authTextFieldWithError(
                controller: TextEditingController(),
                context: context,
                isError: false,
                hintText: TextConstant.pastevoucherCode,
              ).padSymmetric(horizontal: 30),
              const Divider(thickness: 1)
            ].columnInPadding(10),
          ),

          //all items section
          Column(
              children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TextConstant.allitems,
                  style: context.theme.textTheme.labelMedium,
                ),
                Text(
                  '₦20,000',
                  style: context.theme.textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TextConstant.deliveryfee,
                  style: context.theme.textTheme.labelMedium,
                ),
                Text(
                  '₦${deliveryfee.asData?.valueOrNull}',
                  style: context.theme.textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${TextConstant.discount} (20%)',
                  style: context.theme.textTheme.labelMedium,
                ),
                Text(
                  '-₦6,130.23',
                  style: context.theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const Divider(thickness: 1)
          ].columnInPadding(10)),

          // total
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstant.total,
                  style: context.theme.textTheme.labelMedium,
                ),
                Text(
                  '₦80,000.00',
                  style: context.theme.textTheme.titleLarge?.copyWith(
                    color: TagoLight.primaryColor,
                  ),
                ),
              ].columnInPadding(10)),
          //confirm order btn
          ElevatedButton(
            onPressed: () {},
            child: const Text(TextConstant.confirmOrder),
          ).padOnly(top: 25, bottom: 45)
        ],
      ),
    );
  }

  RadioListTile<int> radioListTileWidget({
    required Function(int?)? onChanged,
    required String title,
    required bool isAvailable,
    required int selectedValue,
    required int value,
  }) {
    return RadioListTile(
      title: Text(
        title,
        style: context.theme.textTheme.bodySmall,
      ),
      value: value,
      secondary: isAvailable == false
          ? const Text(
              TextConstant.unAvailable,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 4,
                  backgroundColor: context.theme.primaryColor,
                ),
                const Text(TextConstant.available)
              ].rowInPadding(7),
            ),
      groupValue: selectedValue,
      onChanged: onChanged,
    );
  }
}

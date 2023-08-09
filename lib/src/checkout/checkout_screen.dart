import 'package:tago/app.dart';
import 'package:tago/config/extensions/debug_frame.dart';

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
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            TextConstant.deliveringTo,
            style: context.theme.textTheme.bodyLarge,
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
            minLeadingWidth: 10,
            shape: const Border(bottom: BorderSide(width: 0.1)),
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Icon(
                  Icons.location_on_outlined,
                  color: TagoDark.primaryColor,
                ),
              ],
            ),
            title: Text(
              '''22b, Adesemoye Street, 
Ikeja, Lagos 
101221''',
              style: context.theme.textTheme.titleMedium,
            ),
            trailing: TextButton(
              onPressed: () {},
              child: const Text(TextConstant.editAddress),
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
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: TagoLight.orange,
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
                                '${TextConstant.deliveredIn} 15 ${TextConstant.minutes}',
                                style: context.theme.textTheme.bodySmall
                                    ?.copyWith(
                                        color:
                                            TagoLight.scaffoldBackgroundColor),
                              ),
                            ].rowInPadding(5),
                          ),
                        ),
                        //schedule for later
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: TagoLight.textFieldBorder,
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
                                        color:
                                            TagoLight.scaffoldBackgroundColor),
                              ),
                            ].rowInPadding(5),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ].columnInPadding(10))
              .padOnly(top: 25),

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
                    Text(
                      '027372872373',
                      style: context.theme.textTheme.labelMedium,
                    ).padOnly(right: 5),
                    Text(
                      TextConstant.notConfirmed,
                      style: context.theme.textTheme.titleMedium?.copyWith(
                          color: TagoDark.orange,
                          fontWeight: AppFontWeight.w500),
                    ),
                  ],
                ),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text(TextConstant.edit),
                ),
              ),
            ],
          ),

          //payment method
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
                            ),
                            ListTile(
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

//RREVIEW ITEMS
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
              Text(
                'N20,000',
                style: context.theme.textTheme.labelMedium,
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
                  '₦800.44',
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
}

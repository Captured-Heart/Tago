import 'package:tago/app.dart';

Column checkOutChoosePaymentModalSheet(BuildContext context) {
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
      paymentMethodListTile(
          context: context,
          leading: FontAwesomeIcons.moneyBill,
          title: TextConstant.paywithcash,
          onTap: () => Navigator.pop(context, PaymentMethodsType.cash)),
      paymentMethodListTile(
          context: context,
          leading: FontAwesomeIcons.ccMastercard,
          title: TextConstant.paywithcard,
          onTap: () => Navigator.pop(context, PaymentMethodsType.card)),
      paymentMethodListTile(
          context: context,
          leading: Icons.north_east_outlined,
          title: TextConstant.paywithbank,
          onTap: () => Navigator.pop(context, PaymentMethodsType.bankTransfer)),

      // ListTile(
      //   minLeadingWidth: 25,
      //   contentPadding: const EdgeInsets.symmetric(vertical: 5),
      //   shape: const Border(bottom: BorderSide(width: 0.1)),
      //   leading: const Icon(
      //     FontAwesomeIcons.ccMastercard,
      //   ),
      //   title: Text(
      //     TextConstant.paywithcard,
      //     style: context.theme.textTheme.titleMedium
      //         ?.copyWith(fontWeight: AppFontWeight.w500),
      //   ),
      //   trailing: IconButton(
      //     onPressed: () {},
      //     icon: const Icon(
      //       Icons.chevron_right_rounded,
      //       size: 28,
      //     ),
      //   ),
      // ),
      // ListTile(
      //   minLeadingWidth: 25,
      //   contentPadding: const EdgeInsets.symmetric(vertical: 5),
      //   leading: const Icon(
      //     Icons.north_east_outlined,
      //   ),
      //   title: Text(
      //     TextConstant.paywithbank,
      //     style: context.theme.textTheme.titleMedium
      //         ?.copyWith(fontWeight: AppFontWeight.w500),
      //   ),
      //   trailing: IconButton(
      //     onPressed: () {},
      //     icon: const Icon(
      //       Icons.chevron_right_rounded,
      //       size: 28,
      //     ),
      //   ),
      // ),
    ],
  );
}

ListTile paymentMethodListTile(
    {required BuildContext context,
    required IconData leading,
    required String title,
    required VoidCallback onTap}) {
  return ListTile(
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(vertical: 5),
    minLeadingWidth: 25,
    shape: const Border(bottom: BorderSide(width: 0.1)),
    leading: Icon(
      leading,
    ),
    title: Text(
      title,
      style: context.theme.textTheme.titleMedium
          ?.copyWith(fontWeight: AppFontWeight.w500),
    ),
    trailing: const Icon(
      Icons.chevron_right_rounded,
      size: 28,
    ),
  );
}

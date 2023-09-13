import 'package:tago/app.dart';

Column checkoutPaymentMethodWidget(BuildContext context) {
  return Column(
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
                return checkOutChoosePaymentModalSheet(context).padAll(20);
              },
            );
          },
          child: const Text(TextConstant.choose),
        ),
      ),
    ],
  );
}

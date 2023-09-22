import 'package:tago/app.dart';

Column checkoutDeliveryToWidget(
    BuildContext context, AsyncValue<AccountModel> accountInfo) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        TextConstant.deliveringTo,
        style: context.theme.textTheme.bodyLarge,
      ),
      ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
    ],
  );
}

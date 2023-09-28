import 'package:tago/app.dart';

Column checkoutDeliveryToWidget(BuildContext context, AddressModel? address) {
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
          '${address?.apartmentNumber ?? ''}, ${address?.streetAddress ?? TextConstant.noAddressFound}, ${address?.city ?? ''}, ${address?.state ?? ''}',
          style: context.theme.textTheme.labelMedium,
        ),
        trailing: TextButton(
          style: TextButton.styleFrom(
            textStyle: AppTextStyle.textButtonW600_12,
          ),
          onPressed: () {
            if (address?.streetAddress == null) {
              push(context, const AddNewAddressScreen());
            } else {
              HiveHelper().saveData(HiveKeys.fromCheckout.keys, HiveKeys.fromCheckout.keys);

              push(context, const AddressBookScreen());
            }
          },
          child: Text(
            address?.streetAddress == null ? TextConstant.addAdress : TextConstant.editAddress,
          ),
        ),
      ),
    ],
  );
}

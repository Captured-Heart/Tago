
  import 'package:tago/app.dart';

Column checkoutPhoneNumberWidget(BuildContext context, AsyncValue<AccountModel> accountInfo) {
    return Column(
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
                  accountInfo.valueOrNull?.phoneNumber.toString() ?? TextConstant.enterthePhoneno,
                  style: context.theme.textTheme.labelMedium,
                ).padOnly(right: 5),
              ),
              accountInfo.valueOrNull?.phoneNumber != null
                  ? const SizedBox.shrink()
                  : Text(
                      TextConstant.notConfirmed,
                      style: context.theme.textTheme.titleMedium
                          ?.copyWith(color: TagoDark.orange, fontWeight: AppFontWeight.w500),
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
    );
  }

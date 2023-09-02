import 'package:tago/app.dart';

class ConfirmPhoneNumberScreen extends ConsumerWidget {
  static const String routeName = 'confirmPhone';
  final TextEditingControllerClass controller = TextEditingControllerClass();
  ConfirmPhoneNumberScreen({
    super.key,
    this.phoneno,
  });
  final String? phoneno;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FullScreenLoader(
      isLoading: ref.watch(authAsyncNotifierProvider).isLoading,
      child: Scaffold(
          appBar: appBarWidget(
            context: context,
            isLeading: true,
            title: TextConstant.confirmPhoneNo,
            suffixIcon: TextButton(
              onPressed: () {},
              child: const Text(TextConstant.skip),
            ),
          ),
          body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        TextConstant.wehavesent6digit,
                      ),
                      subtitle: Row(
                          children: [
                        const Text(TextConstant.enterthecode),
                        Text(phoneno!),
                      ].rowInPadding(5)),
                    ),
                    authTextFieldWithError(
                        controller: controller.otpCode,
                        context: context,
                        isError: false,
                        hintText: TextConstant.sixdigitcode,
                        maxLength: 6,
                        validator: RequiredValidator(errorText: otpisInvalid)),
                    //
                    SizedBox(
                      width: context.sizeWidth(1),
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(authAsyncNotifierProvider.notifier)
                              .verifyPhoneNumberMethod(
                            map: {
                              AuthTypeField.phoneNumber.name: phoneno,
                              AuthTypeField.otp.name: controller.otpCode.text,
                            },
                            context: context,
                          );
                          // push(context, const AddAddressScreen());
                          log(controller.otpCode.text);
                          log(HiveHelper().getData(HiveKeys.token.keys));
                        },
                        child: const Text(TextConstant.confirm),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          TextConstant.haventreceived,
                          style: AppTextStyle.normalBodyTitle,
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(authAsyncNotifierProvider.notifier)
                                .resendOtpMethod(context);
                          },
                          child: const Text(TextConstant.resend),
                        )
                      ],
                    )
                  ].columnInPadding(10))
              .padSymmetric(
            horizontal: context.sizeWidth(0.04),
          )),
    );
  }
}

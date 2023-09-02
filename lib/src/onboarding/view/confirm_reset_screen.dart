import 'package:tago/app.dart';
import 'package:tago/src/onboarding/controllers/auth_user_async_notifier.dart';
import 'package:tago/src/widgets/app_loader.dart';

class ConfirmResetCodeScreen extends ConsumerWidget {
  ConfirmResetCodeScreen({
    super.key,
    required this.phoneNo,
  });
  final TextEditingControllerClass controller = TextEditingControllerClass();
  final String phoneNo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FullScreenLoader(
      isLoading: ref.watch(authAsyncNotifierProvider).isLoading,
      child: Scaffold(
          appBar: appBarWidget(
            context: context,
            isLeading: true,
            title: TextConstant.confirmResetcode,
          ),
          body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        TextConstant.wehavesent6digit,
                      ),
                      subtitle: Text(TextConstant.confirmBytypingthecode),
                    ),
                    authTextFieldWithError(
                      controller: controller.otpCode,
                      context: context,
                      isError: false,
                      hintText: TextConstant.sixdigitcode,
                    ),
                    //
                    SizedBox(
                      width: context.sizeWidth(1),
                      child: ElevatedButton(
                        onPressed: () {
                          ref
                              .read(authAsyncNotifierProvider.notifier)
                              .verifyResetcodeMethod(
                            map: {
                              AuthTypeField.otp.name: controller.otpCode.text,
                              AuthTypeField.phoneNumber.name: phoneNo,
                            },
                            context: context,
                          );
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
                            log(phoneNo);

                            ref
                                .read(authAsyncNotifierProvider.notifier)
                                .forgotPasswordAsyncMethod(
                              map: {
                                AuthTypeField.phoneNumber.name: phoneNo,
                              },
                              phoneNo: phoneNo,
                              context: context,
                              onNavigation: () {},
                            );
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

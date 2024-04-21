import 'package:tago/app.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingControllerClass controller = TextEditingControllerClass();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FullScreenLoader(
      isLoading: ref.watch(authAsyncNotifierProvider).isLoading,
      child: Scaffold(
          appBar: appBarWidget(
            context: context,
            isLeading: true,
            title: TextConstant.forgotpassword,
          ),
          body: Form(
            key: controller.signUpformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    TextConstant.phoneno,
                  ),
                  subtitle: Text(TextConstant.enterthePhoneno),
                ),
                authTextFieldWithError(
                  controller: controller.phoneNoController,
                  context: context,
                  isError: false,
                  hintText: TextConstant.phoneno,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  validator: LengthRangeValidator(
                    min: 11,
                    max: 11,
                    errorText: phoneValidation,
                  ),
                ),
                //send reset code
                SizedBox(
                  width: context.sizeWidth(1),
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.signUpformKey.currentState!.validate()) {
                        ref
                            .read(authAsyncNotifierProvider.notifier)
                            .forgotPasswordAsyncMethod(
                          map: {
                            AuthTypeField.phoneNumber.name:
                                controller.phoneNoController.text
                          },
                          phoneNo: controller.phoneNoController.text,
                          context: context,
                          onNavigation: () {
                            push(
                              context,
                              ConfirmResetCodeScreen(
                                phoneNo: controller.phoneNoController.text,
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: const Text(TextConstant.sendResetcode),
                  ),
                ),
              ].columnInPadding(10),
            ).padSymmetric(
              horizontal: context.sizeWidth(0.04),
            ),
          )),
    );
  }
}

import 'package:tago/app.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingControllerClass controller = TextEditingControllerClass();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(authUserProvider);
    return Scaffold(
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
                      ref.read(authUserProvider.notifier).forgotPassword(
                          {'phoneNumber': controller.phoneNoController.text},
                          () {
                        push(
                            context,
                            ConfirmResetCodeScreen(
                              phoneNo: controller.phoneNoController.text,
                            ));
                      });

                      //
                      // authState.isSuccess == true &&
                      //         authState.isLoading == false
                      //     ? push(context,  ConfirmResetCodeScreen())
                      //     : null;
                    }
                  },
                  child: const Text(TextConstant.sendResetcode),
                ),
              ),
            ].columnInPadding(10),
          ).padSymmetric(
            horizontal: context.sizeWidth(0.04),
          ),
        ));
  }
}

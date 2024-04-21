import 'package:tago/app.dart';

class ChangePasswordScreen extends ConsumerWidget {
  ChangePasswordScreen({super.key});
  final TextEditingControllerClass controller = TextEditingControllerClass();

  final passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: passwordIsRequired),
      MinLengthValidator(
        8,
        errorText: passwordMustBeAtleast,
      ),
    ],
  );
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FullScreenLoader(
      isLoading: ref.watch(authAsyncNotifierProvider).isLoading,
      child: Scaffold(
        appBar: appBarWidget(
          context: context,
          isLeading: true,
          title: TextConstant.changePassword,
        ),
        body: Form(
          key: controller.changePassformKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  TextConstant.password,
                ),
                subtitle: Text(TextConstant.enterthePassword),
              ),
              authTextFieldWithError(
                controller: controller.oldPassWordController,
                context: context,
                isError: false,
                label: TextConstant.oldPassword.toTitleCase(),
                keyboardType: TextInputType.phone,
                validator: passwordValidator,
              ),
              authTextFieldWithError(
                controller: controller.newPassWordController,
                context: context,
                isError: false,
                label: TextConstant.newPassword.toTitleCase(),
                keyboardType: TextInputType.phone,
                validator: passwordValidator,
              ),
              authTextFieldWithError(
                controller: controller.confirmPassWordController,
                context: context,
                isError: false,
                label: TextConstant.confirmNewpassword.toTitleCase(),
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    MatchValidator(errorText: AuthErrors.passwordDoesNotMatch.errorMessage)
                        .validateMatch(val!, controller.newPassWordController.text),
              ),
              //change password button
              SizedBox(
                width: context.sizeWidth(1),
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.changePassformKey.currentState!.validate()) {
                      ref.read(authAsyncNotifierProvider.notifier).changePasswordMethod(
                        map: {
                          'oldPassword': controller.oldPassWordController.text,
                          'password': controller.newPassWordController.text,
                        },
                        context: context,
                        onNavigation: () {
                          push(
                            context,
                            ResetSuccessfulScreen(
                              onPop: () {
                                pop(context);
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text(TextConstant.changePassword),
                ),
              ),
            ].columnInPadding(10),
          ).padSymmetric(horizontal: context.sizeWidth(0.04)),
        ),
      ),
    );
  }
}

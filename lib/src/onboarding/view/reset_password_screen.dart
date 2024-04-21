import 'package:tago/app.dart';
import 'package:tago/src/onboarding/controllers/auth_user_async_notifier.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  static const String routeName = 'reset password';

  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        isLeading: true,
        title: TextConstant.resetPassword,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              TextConstant.createAnewpassword,
            ),
            subtitle: Text(
              TextConstant.enteryournewpassowrd,
            ),
          ).padOnly(bottom: 5),
          Form(
            key: controller.signUpformKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                authTextFieldWithError(
                  controller: controller.passWordController,
                  context: context,
                  isError: false,
                  hintText: TextConstant.enterAnewPassword,
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: passwordIsRequired),
                      MinLengthValidator(
                        8,
                        errorText: passwordMustBeAtleast,
                      ),
                      // PatternValidator(
                      //   r'(?=.*?[#?!@$%^&*-])',
                      //   errorText: passwordMustHaveaSymbol,
                      // ),
                    ],
                  ),
                ),
                authTextFieldWithError(
                  controller: controller.passWordController2,
                  context: context,
                  isError: false,
                  hintText: TextConstant.confirmNewpassword,
                  validator: (val) => MatchValidator(
                          errorText:
                              AuthErrors.passwordDoesNotMatch.errorMessage)
                      .validateMatch(val!, controller.passWordController.text),
                ),
              ].columnInPadding(10),
            ),
          ),
          //
          SizedBox(
            width: context.sizeWidth(1),
            child: ElevatedButton(
              onPressed: () {
                if (controller.signUpformKey.currentState!.validate()) {
                  log(HiveHelper().getData(HiveKeys.token.keys));
                  ref
                      .read(authAsyncNotifierProvider.notifier)
                      .resetPasswordMethod(map: {
                    AuthTypeField.password.name:
                        controller.passWordController.text,
                    AuthTypeField.token.name:
                        HiveHelper().getData(HiveKeys.token.keys)
                  }, context: context);
                }
              },
              child: const Text(TextConstant.setNewpassword),
            ),
          ),
        ],
      ).padSymmetric(
        horizontal: context.sizeWidth(0.05),
      ),
    );
  }
}

import 'package:tago/app.dart';
import 'package:tago/src/onboarding/controllers/auth_user_async_notifier.dart';
import 'package:tago/src/widgets/app_loader.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String routeName = 'signup';

  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  final HiveHelper helper = HiveHelper();
  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authUserProvider);
    final authState = ref.watch(authAsyncNotifierProvider);
    final isError = authState is AsyncError;
    // log(authState.state.asData?.value ?? 'ok');
    log('isErrorLog: $isError');
    return FullScreenLoader(
      isLoading: authState.isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBarWidget(
          context: context,
          isLeading: true,
          title: TextConstant.createAcct,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                TextConstant.welcometotago,
              ),
              subtitle: Text(
                TextConstant.groceriesDeliveryInMins,
              ),
            ).padOnly(bottom: 5),
            Form(
              key: controller.signUpformKey,
              child: Column(
                children: [
                  authTextFieldWithError(
                    controller: controller.fullNameController,
                    context: context,
                    isError: false,
                    hintText: TextConstant.fullname,
                    validator: RequiredValidator(errorText: requiredValue),
                    inputFormatters: [],
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
                  authTextFieldWithError(
                    controller: controller.passWordController,
                    context: context,
                    isError: false,
                    hintText: TextConstant.createpassword,
                    validator: MultiValidator(
                      [
                        RequiredValidator(errorText: passwordIsRequired),
                        MinLengthValidator(
                          8,
                          errorText: passwordMustBeAtleast,
                        ),
                        PatternValidator(
                          r'(?=.*?[#?!@$%^&*-])',
                          errorText: passwordMustHaveaSymbol,
                        )
                      ],
                    ),
                  ),
                  //!
                  // Text(authState.error.toString()),
                ].columnInPadding(10),
              ),
            ),

            //
            SizedBox(
              width: context.sizeWidth(1),
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.signUpformKey.currentState!.validate()) {
                    await ref
                        .read(authAsyncNotifierProvider.notifier)
                        .signUpAsyncMethod(
                      context: context,
                      phoneno: controller.phoneNoController.text,
                      map: {
                        AuthTypeField.fullName.name:
                            controller.fullNameController.text,
                        AuthTypeField.password.name:
                            controller.passWordController.text,
                        AuthTypeField.phoneNumber.name:
                            controller.phoneNoController.text,
                      },
                    );
                  }
                },
                child: const Text(TextConstant.signup),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TextConstant.alreadyhaveacct,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: AppFontWeight.w700,
                      color: TagoLight.textBold),
                ),
                TextButton(
                  onPressed: () async {
                    pushReplaceNamed(context, SignInScreen.routeName);
                  },
                  child: const Text(TextConstant.signIn),
                )
              ],
            ),
          ],
        ).padSymmetric(
          horizontal: context.sizeWidth(0.05),
        ),
      ),
    );
  }
}

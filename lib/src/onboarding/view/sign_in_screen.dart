import 'package:tago/app.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const String routeName = 'signIn';

  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignInScreen> {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  // final HiveHelper hive = HiveHelper();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authAsyncNotifierProvider);
    return FullScreenLoader(
      isLoading: authState.isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBarWidget(
          context: context,
          isLeading: true,
          title: TextConstant.signIn,
        ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                TextConstant.welcomeBack,
              ),
              subtitle: Text(
                TextConstant.letsgetyouback,
              ),
            ).padOnly(bottom: 5),
            Form(
              key: controller.signInformKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  authTextFieldWithError(
                    context: context,
                    controller: controller.phoneNoController,
                    focusNode: controller.phoneNoFocusMode,
                    isError: false,
                    hintText: TextConstant.phoneno,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    validator: LengthRangeValidator(
                      min: 11,
                      max: 11,
                      errorText: phoneValidation,
                    ),
                    onChanged: (value) {
                      if (value.length > 10) {
                        controller.fieldFocusChange(
                          context,
                          currentFocus: controller.phoneNoFocusMode,
                          nextFocus: controller.passwordFocusMode,
                        );
                      }
                    },
                  ),
                  authTextFieldWithError(
                    context: context,
                    controller: controller.passWordController,
                    focusNode: controller.passwordFocusMode,
                    isError: false,
                    obscureText: isVisible,
                    hintText: TextConstant.password,
                    textInputAction: TextInputAction.done,
                    suffixIcon: IconButton(
                      color: TagoLight.textBold.withOpacity(0.7),
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible == false
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    validator: MultiValidator(
                      [
                        RequiredValidator(errorText: passwordIsRequired),
                        MinLengthValidator(
                          8,
                          errorText: passwordMustBeAtleast,
                        ),
                      ],
                    ),
                  ).padOnly(bottom: 10),

                  // forgot password
                  InkWell(
                    onTap: () {
                      push(context, ForgotPasswordScreen());
                    },
                    child: Text(
                      TextConstant.forgotpassword,
                      style: context.theme.textTheme.bodyLarge?.copyWith(),
                    ),
                  )
                ].columnInPadding(10),
              ),
            ),

            //
            SizedBox(
              width: context.sizeWidth(1),
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.signInformKey.currentState!.validate()) {
                    ref.read(authAsyncNotifierProvider.notifier).signInAsyncMethod(
                      map: {
                        'password': controller.passWordController.text,
                        'phoneNumber': controller.phoneNoController.text,
                      },
                      context: context,
                      onNavigation: () {
                        if (HiveHelper().getData(HiveKeys.role.name) == AuthRoleType.user.name) {
                          pushReplacement(
                            context,
                            const MainScreen(),
                          );
                        } else {
                          pushReplacement(
                            context,
                            const RiderMainScreen(),
                          );
                        }
                      },
                    );
                  }
                  // push(context, const MainScreen());
                },
                child: const Text(TextConstant.signIn),
              ),
            ).padSymmetric(vertical: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TextConstant.newtoTago,
                  style: AppTextStyle.normalBodyTitle,
                ),
                TextButton(
                  onPressed: () {
                    push(
                      context,
                      const AddAddressScreen(),
                    );

                    // pushReplaceNamed(context, SignUpScreen.routeName);
                  },
                  child: const Text(TextConstant.signup),
                )
              ],
            )
          ],
        ).padSymmetric(
          horizontal: context.sizeWidth(0.05),
        ),
      ),
    );
  }
}

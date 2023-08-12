import 'package:tago/app.dart';
import 'package:tago/config/constants/auth_error_constants.dart';
import 'package:tago/src/widgets/app_loader.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String routeName = 'signup';

  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authUserProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget(
        context: context,
        isLeading: true,
        title: TextConstant.createAcct,
      ),
      body: FullScreenLoader(
        isLoading: authState.isLoading,
        title: authState.errorMessage ?? '',
        child: Column(
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
                ].columnInPadding(10),
              ),
            ),

            //
            SizedBox(
              width: context.sizeWidth(1),
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.signUpformKey.currentState!.validate()) {
                    await ref.read(authUserProvider.notifier).signUpUsers(
                      {
                        'fullName': controller.fullNameController.text,
                        'password': controller.passWordController.text,
                        'phoneNumber': controller.phoneNoController.text,
                      },
                    ).then((_) {
                      !authState.isSuccess! && !authState.isLoading
                          ? showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                              builder: (context) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.cancel,
                                          color: TagoLight.textError,
                                          size: 44,
                                        ),
                                        ListTile(
                                          title: const Text(
                                            'Error',
                                            textScaleFactor: 1.1,
                                            textAlign: TextAlign.center,
                                          ).padOnly(bottom: 10),
                                          subtitle: Text(
                                            authState.errorMessage ??
                                                'invalid phone number/password combination',
                                            textScaleFactor: 1.1,
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ].columnInPadding(20))
                                  .padSymmetric(vertical: 40, horizontal: 30))
                          : const SizedBox.shrink();
                    });
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

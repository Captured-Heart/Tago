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
    final authState1 = ref.watch(authAsyncNotifierProvider);
    final isError = authState1 is AsyncError;
    // log(authState.state.asData?.value ?? 'ok');
    log('isErrorLog: $isError');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget(
        context: context,
        isLeading: true,
        title: TextConstant.createAcct,
      ),
      body: FullScreenLoader(
        isLoading: authState1.isLoading,
        title: '${authState1.error}' ?? '',
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
                  Text(authState1.error.toString() ?? 'df'),
                ].columnInPadding(10),
              ),
            ),

            //
            SizedBox(
              width: context.sizeWidth(1),
              child: ElevatedButton(
                onPressed: () async {
                  // push(context, ConfirmPhoneNumberScreen());
                  if (controller.signUpformKey.currentState!.validate()) {
                    await ref
                        .read(authAsyncNotifierProvider.notifier)
                        .signUpAsyncMethod(
                      {
                        'fullName': controller.fullNameController.text,
                        'password': controller.passWordController.text,
                        'phoneNumber': controller.phoneNoController.text,
                      },
                    ).then((_) {
                      showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                          builder: (context1) => Consumer(
                                builder: (context, ref, child) {
                                  final authState =
                                      ref.watch(authAsyncNotifierProvider);

                                  return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              !authState.isLoading &&
                                                      !authState.hasValue ==
                                                          true
                                                  ? Icons.done
                                                  : Icons.cancel,
                                              color: !authState.hasError == true
                                                  ? TagoLight.primaryColor
                                                  : TagoLight.textError,
                                              size: 44,
                                            ),
                                            ListTile(
                                              title: Text(
                                                !authState.hasError == true
                                                    ? 'succesful'
                                                    : 'Error',
                                                textScaleFactor: 1.1,
                                                textAlign: TextAlign.center,
                                              ).padOnly(bottom: 10),
                                              subtitle: Text(
                                                '${authState.asData!.value}' ??
                                                    'invalid phone number/password combination',
                                                textScaleFactor: 1.1,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ].columnInPadding(20))
                                      .padSymmetric(
                                          vertical: 40, horizontal: 30);
                                },
                              ));
                    });
                    // await ref.read(authUserProvider.notifier).signUpUsers(
                    //   {
                    //     'fullName': controller.fullNameController.text,
                    //     'password': controller.passWordController.text,
                    //     'phoneNumber': controller.phoneNoController.text,
                    //   },
                    // )

                    // .then((_) {
                    //   !authState.isSuccess! && !authState.isLoading
                    //       ? showModalBottomSheet(
                    //           context: context,
                    //           shape: const RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.only(
                    //             topLeft: Radius.circular(20),
                    //             topRight: Radius.circular(20),
                    //           )),
                    //           builder: (context1) => Consumer(
                    //                 builder: (context, ref, child) {
                    //                   return Column(
                    //                           crossAxisAlignment:
                    //                               CrossAxisAlignment.center,
                    //                           mainAxisSize: MainAxisSize.min,
                    //                           children: [
                    //                             Icon(
                    //                               ref
                    //                                           .watch(
                    //                                               authUserProvider)
                    //                                           .isSuccess ==
                    //                                       true
                    //                                   ? Icons.done
                    //                                   : Icons.cancel,
                    //                               color: ref
                    //                                           .watch(
                    //                                               authUserProvider)
                    //                                           .isSuccess ==
                    //                                       true
                    //                                   ? TagoLight.primaryColor
                    //                                   : TagoLight.textError,
                    //                               size: 44,
                    //                             ),
                    //                             ListTile(
                    //                               title: Text(
                    //                                 ref
                    //                                             .watch(
                    //                                                 authUserProvider)
                    //                                             .isSuccess ==
                    //                                         true
                    //                                     ? 'succesful'
                    //                                     : 'Error',
                    //                                 textScaleFactor: 1.1,
                    //                                 textAlign: TextAlign.center,
                    //                               ).padOnly(bottom: 10),
                    //                               subtitle: Text(
                    //                                 ref
                    //                                         .watch(
                    //                                             authUserProvider)
                    //                                         .errorMessage ??
                    //                                     'invalid phone number/password combination',
                    //                                 textScaleFactor: 1.1,
                    //                                 textAlign: TextAlign.center,
                    //                               ),
                    //                             )
                    //                           ].columnInPadding(20))
                    //                       .padSymmetric(
                    //                           vertical: 40, horizontal: 30);
                    //                 },
                    //               ))
                    //       : const SizedBox.shrink();
                    // });
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

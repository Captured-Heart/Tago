import 'package:tago/screens/onboarding/forgot_password_screen.dart';

import '../../app.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const String routeName = 'signIn';

  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        isLeading: true,
        title: TextConstant.signIn,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              authTextFieldWithError(
                controller: TextEditingController(),
                context: context,
                isError: false,
                hintText: TextConstant.fullname,
              ),
              authTextFieldWithError(
                controller: TextEditingController(),
                context: context,
                isError: false,
                hintText: TextConstant.phoneno,
              ),

              // forgot password
              InkWell(
                onTap: () {
                  push(context, const ForgotPasswordScreen());
                },
                child: Text(
                  TextConstant.forgotpassword,
                  style: context.theme.textTheme.bodyLarge?.copyWith(),
                ),
              )
            ].columnInPadding(10),
          ),
          //
          SizedBox(
            width: context.sizeWidth(1),
            child: ElevatedButton(
              onPressed: () {},
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
                onPressed: () {},
                child: const Text(TextConstant.signup),
              )
            ],
          )
        ],
      ).padSymmetric(
        horizontal: context.sizeWidth(0.05),
      ),
    );
  }
}

import 'package:tago/screens/onboarding/confirm_phone_screen.dart';

import '../../app.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String routeName = 'signup';

  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Column(
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
              authTextFieldWithError(
                controller: TextEditingController(),
                context: context,
                isError: false,
                hintText: TextConstant.createpassword,
              ),
            ].columnInPadding(10),
          ),
          //
          SizedBox(
            width: context.sizeWidth(1),
            child: ElevatedButton(
              onPressed: () {
                pushNamed(context, ConfirmPhoneNumberScreen.routeName);
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
                  color: TagoLight.textBold
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(TextConstant.signIn),
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

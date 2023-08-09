import 'package:tago/app.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: appBarWidget(
          context: context,
          isLeading: true,
          title: TextConstant.forgotpassword,
        ),
        body: Column(
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
                    controller: TextEditingController(),
                    context: context,
                    isError: false,
                    hintText: TextConstant.phoneno,
                  ),
                  //send reset code
                  SizedBox(
                    width: context.sizeWidth(1),
                    child: ElevatedButton(
                      onPressed: () {
                        push(context, const ConfirmResetCodeScreen());
                      },
                      child: const Text(TextConstant.sendResetcode),
                    ),
                  ),
                ].columnInPadding(10))
            .padSymmetric(
          horizontal: context.sizeWidth(0.04),
        ));
  }
}

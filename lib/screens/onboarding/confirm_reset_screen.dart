import 'package:tago/app.dart';
import 'package:tago/screens/onboarding/reset_password_screen.dart';

class ConfirmResetCodeScreen extends ConsumerWidget {
  const ConfirmResetCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: appBarWidget(
          context: context,
          isLeading: true,
          title: TextConstant.confirmResetcode,
        ),
        body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      TextConstant.wehavesent4digit,
                    ),
                    subtitle: Text(TextConstant.confirmBytypingthecode),
                  ),
                  authTextFieldWithError(
                    controller: TextEditingController(),
                    context: context,
                    isError: false,
                    hintText: TextConstant.fourdigitcode,
                  ),
                  //
                  SizedBox(
                    width: context.sizeWidth(1),
                    child: ElevatedButton(
                      onPressed: () {
                       // confirmn code
                        push(context, const ResetPasswordScreen());
                      },
                      child: const Text(TextConstant.confirm),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        TextConstant.haventreceived,
                        style: AppTextStyle.normalBodyTitle,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(TextConstant.resend),
                      )
                    ],
                  )
                ].columnInPadding(10))
            .padSymmetric(
          horizontal: context.sizeWidth(0.04),
        ));
  }
}

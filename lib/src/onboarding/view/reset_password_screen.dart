

import 'package:tago/app.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  static const String routeName = 'reset password';

  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
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
          Column(
            children: [
              authTextFieldWithError(
                controller: TextEditingController(),
                context: context,
                isError: false,
                hintText: TextConstant.enterAnewPassword,
              ),
              authTextFieldWithError(
                controller: TextEditingController(),
                context: context,
                isError: false,
                hintText: TextConstant.confirmNewpassword,
              ),
            ].columnInPadding(10),
          ),
          //
          SizedBox(
            width: context.sizeWidth(1),
            child: ElevatedButton(
              onPressed: () {
                push(
                  context,
                  const ResetSuccessfulScreen(),
                );
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

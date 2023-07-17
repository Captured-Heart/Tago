import 'package:tago/screens/onboarding/add_address_manually.dart';
import 'package:tago/screens/onboarding/sign_in_screen.dart';
import 'package:tago/utils/extensions/debug_frame.dart';

import '../../app.dart';

class ResetSuccessfulScreen extends ConsumerWidget {
  static const String routeName = 'reset succesful';
  const ResetSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.resetsuccessful,
        isLeading: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.check_circle_rounded,
            color: TagoDark.primaryColor,
            size: context.sizeHeight(0.0752),
          ),
        ).padSymmetric(
          vertical: context.sizeHeight(0.04),
        ),
        Text(
          TextConstant.passwordresetsuccesful,
          style: context.theme.textTheme.titleMedium,
        ).padOnly(bottom: 8),
        Text(
          TextConstant.proceedtosignin,
          style: context.theme.textTheme.bodyMedium,
        ),
        SizedBox(
          width: context.sizeWidth(1),
          child: ElevatedButton(
            onPressed: () {
              pushReplaceNamed(context, SignInScreen.routeName);
            },
            child: const Text(TextConstant.signIn),
          ),
        ).padSymmetric(vertical: 30)
      ]).padAll(20),
    );
  }
}

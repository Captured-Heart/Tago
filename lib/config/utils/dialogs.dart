import 'package:tago/app.dart';

import '../../src/onboarding/controllers/auth_user_async_notifier.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showScaffoldSnackBar(SnackBar snackBar) =>
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);

void showScaffoldSnackBarMessage(String message) =>
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.left,
        ),
        duration: const Duration(seconds: 2),
      ),
    );

void warningDialogs(String errorMessage) => Dialog(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
            errorMessage,
            textScaleFactor: 1.1,
            textAlign: TextAlign.center,
          ),
        )
      ].columnInPadding(20),
    ).padSymmetric(vertical: 40, horizontal: 30));

//
Future<void> showAuthBottomSheet({
  required BuildContext context,
}) async {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    )),
    builder: (context1) => Consumer(
      builder: (context, ref, child) {
        final authState1 = ref.watch(authAsyncNotifierProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                '${authState1.error}',
                // 'invalid phone number/password combination',
                textScaleFactor: 1.1,
                textAlign: TextAlign.center,
              ),
            )
          ].columnInPadding(20),
        ).padSymmetric(vertical: 40, horizontal: 30);
      },
    ),
  );
}

// static showSnackBar(context, message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           toBeginningOfSentenceCase(message)!,
//           textAlign: TextAlign.center,
//         ),
//         duration: const Duration(milliseconds: 1100),
//       ),
//     );
//   }
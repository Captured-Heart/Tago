import 'package:tago/app.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showScaffoldSnackBar(SnackBar snackBar) =>
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);

void showScaffoldSnackBarMessage(
  String message, {
  bool isError = false,
  int? duration,
}) =>
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isError ? Icons.cancel : Icons.check_circle,
                color: isError ? TagoLight.textError : TagoLight.primaryColor,
              ),
              Expanded(
                child: Text(
                  message,
                  textAlign: TextAlign.left,
                ),
              ),
            ].rowInPadding(5)),
        duration: Duration(seconds: duration ?? 5),
      ),
    );

void warningDialogs({
  required BuildContext context,
  required String errorMessage,
  VoidCallback? onNegativeAction,
  required VoidCallback onPostiveAction,
  String? title,
}) =>
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titleTextStyle: AppTextStyle.normalBodyTitle,
          title: Text(
            title ?? 'Error',
            textScaleFactor: 1.1,
            textAlign: TextAlign.center,
          ).padOnly(bottom: 10),
          content: Text(
            errorMessage,
            textScaleFactor: 1.1,
            textAlign: TextAlign.center,
          ),
          contentPadding: const EdgeInsets.only(top: 5),
          actionsAlignment: MainAxisAlignment.spaceAround,
          contentTextStyle: context.theme.textTheme.bodyMedium,
          // actionsPadding: EdgeInsets.zero,
          actions: [
            TextButton(
                onPressed: onNegativeAction ??
                    () {
                      pop(context);
                    },
                style:
                    TextButton.styleFrom(foregroundColor: TagoLight.textError),
                child: const Text(TextConstant.cancel)),
            TextButton(
                onPressed: onPostiveAction,
                child: const Text(TextConstant.confirm))
          ],
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     const Icon(
          //       Icons.cancel,
          //       color: TagoLight.textError,
          //       size: 44,
          //     ),
          //     ListTile(
          //       title: Text(
          //         title ?? 'Error',
          //         textScaleFactor: 1.1,
          //         textAlign: TextAlign.center,
          //       ).padOnly(bottom: 10),
          //       subtitle: Text(
          //         errorMessage,
          //         textScaleFactor: 1.1,
          //         textAlign: TextAlign.center,
          //       ),
          //     )
          //   ].columnInPadding(20),
          // ).padSymmetric(vertical: 40, horizontal: 30),
        );
        // Dialog(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         const Icon(
        //           Icons.cancel,
        //           color: TagoLight.textError,
        //           size: 44,
        //         ),
        //         ListTile(
        //           title: Text(
        //             title ?? 'Error',
        //             textScaleFactor: 1.1,
        //             textAlign: TextAlign.center,
        //           ).padOnly(bottom: 10),
        //           subtitle: Text(
        //             errorMessage,
        //             textScaleFactor: 1.1,
        //             textAlign: TextAlign.center,
        //           ),
        //         )
        //       ].columnInPadding(20),
        // ).padSymmetric(vertical: 40, horizontal: 30));
      },
    );

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

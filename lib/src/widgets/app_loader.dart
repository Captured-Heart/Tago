import 'dart:ui';

import 'package:tago/app.dart';

// Widget appLoader({required BuildContext context, required String message}) {
//   return Center(
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Lottie.asset(
//           context.isDarkMode ? loaderDark2 : loaderLight,
//           fit: BoxFit.cover,
//           alignment: Alignment.center,
//           height: MediaQuery.of(context).size.height * 0.2,
//           width: MediaQuery.of(context).size.width * 0.4,
//         ),
//         Text(
//           message,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.headline2?.copyWith(
//                 fontWeight: AppFontWeight.medium,
//                 color: context.isDarkMode
//                     ? BrandColors.colorBackground
//                     : Colors.brown[900],
//               ),
//         )
//       ],
//     ),
//   );
// }

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({
    super.key,
    required this.child,
    required this.isLoading,
    required this.title,
    this.loaderStyleWidget,
  });
  final Widget child;
  final bool isLoading;
  final String title;
  final Widget? loaderStyleWidget;
  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;
    return Stack(
      children: [
        child,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Opacity(
            opacity: 0.2,
            child: ModalBarrier(
                dismissible: false, color: Theme.of(context).primaryColor),
          ),
        ),
        // loaderStyleWidget!
        const CircularProgressIndicator()

        // ??
        //     appLoader(
        //       context: context,
        //       message: title,
        //     )
      ],
    );
  }
}

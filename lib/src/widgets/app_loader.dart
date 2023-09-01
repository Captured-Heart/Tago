import 'dart:ui';

import 'package:tago/app.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({
    super.key,
    required this.child,
    required this.isLoading,
    this.loaderStyleWidget,
  });
  final Widget child;
  final bool isLoading;
  final Widget? loaderStyleWidget;
  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;
    return Stack(
      children: [
        child,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Opacity(
            opacity: 0.01,
            child: ModalBarrier(
                dismissible: false, color: Theme.of(context).primaryColor),
          ),
        ),
        // loaderStyleWidget!
        const Center(child: CircularProgressIndicator())

        // ??
        //     appLoader(
        //       context: context,
        //       message: title,
        //     )
      ],
    );
  }
}

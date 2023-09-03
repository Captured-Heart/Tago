import 'package:tago/app.dart';

Widget shimmerWidget({required Widget child}) {
  return Shimmer.fromColors(
    baseColor: TagoLight.indicatorActiveColor.withOpacity(0.2),
    highlightColor: TagoLight.indicatorInactiveColor,
    period: const Duration(milliseconds: 3000),
    child: child,
  );
}

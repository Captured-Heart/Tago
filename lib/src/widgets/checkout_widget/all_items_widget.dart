import 'package:tago/app.dart';

Row checkOutALLItemsRowWidget({
  required BuildContext context,
  required String leading,
  required String trailing,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          leading,
          style: context.theme.textTheme.labelMedium,
        ),
      ),
      Text(
        trailing,
        style: context.theme.textTheme.bodyMedium,
      ),
    ],
  );
}

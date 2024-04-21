import 'package:tago/app.dart';

RadioListTile<int> radioListTileWidget({
  required Function(int?)? onChanged,
  required String title,
  required bool isAvailable,
  required int selectedValue,
  required int value,
  required BuildContext context,
}) {
  return RadioListTile(
    title: Text(
      title,
      style: context.theme.textTheme.bodySmall,
    ),
    value: value,
    secondary: isAvailable == false
        ? const Text(
            TextConstant.unAvailable,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 4,
                backgroundColor: context.theme.primaryColor,
              ),
              const Text(TextConstant.available)
            ].rowInPadding(7),
          ),
    groupValue: selectedValue,
    onChanged: onChanged,
  );
}

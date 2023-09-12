
import 'package:tago/app.dart';

ListTile drawerListTile({
  required BuildContext context,
  required IconData icons,
  required String title,
  TextStyle? textStyle,
  Color? iconColor,
  double? materialIconSize,
  VoidCallback? onTap,
  bool? isImageLeading,
  bool? isMaterialIcon,
  Widget? imageLeading,
}) {
  return ListTile(
    onTap: onTap,
    shape: const Border(bottom: BorderSide(width: 0.1)),
    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    minLeadingWidth: 1,
    leading: isImageLeading == true
        ? imageLeading
        : isMaterialIcon == true
            ? Icon(
                icons,
                color: iconColor,
                size: materialIconSize ?? 22,
              )
            : FaIcon(
                icons,
                color: iconColor,
                size: 18,
              ),
    title: Text(
      title,
      style: textStyle ?? context.theme.textTheme.titleSmall,
    ),
  );
}
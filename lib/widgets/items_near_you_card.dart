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

Widget itemsNearYouCard({
  required int index,
  required BuildContext context,
  VoidCallback? onTap,
  required String image,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0.3,
          child: Image.asset(
            image,
            height: 140,
            width: context.sizeWidth(1),
            fit: BoxFit.fill,
          ),
        ),
        Text(
          drinkTitle[index],
          textAlign: TextAlign.start,
          style: context.theme.textTheme.labelMedium?.copyWith(
            fontSize: 12,
            fontWeight: AppFontWeight.w500,
            fontFamily: TextConstant.fontFamilyNormal,
          ),
        ).padSymmetric(vertical: 8),
        Text(
          'N20,000',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontFamily: TextConstant.fontFamilyNormal,
            fontSize: 12,
          ),
          textAlign: TextAlign.start,
        )
      ],
    ),
  );
}

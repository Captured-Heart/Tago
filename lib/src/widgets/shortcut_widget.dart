import '../../app.dart';

Widget shortcutWidget({
  required BuildContext context,
  required String name,
  required IconData icon,
}) {
  return Column(children: [
    Container(
      padding: const EdgeInsets.all(12),
      height: 55,
      width: 80,
      color: TagoLight.primaryColor.withOpacity(0.11),
      child: Icon(icon, color: TagoLight.primaryColor),
    ),
    const SizedBox(
      height: 5,
    ),
    Text(
      name,
      style: context.theme.textTheme.bodyMedium?.copyWith(
          fontSize: 12,
          overflow: TextOverflow.ellipsis,
          fontFamily: TextConstant.fontFamilyBold,
          color: TagoDark.textBold),
    )
  ]);
}

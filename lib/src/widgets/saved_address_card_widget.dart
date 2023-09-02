import 'package:tago/app.dart';

Widget savedAddressCard({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String subtitle2,

  VoidCallback? onEdit,
  VoidCallback? onDelete,
  VoidCallback? onTap,

}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      width: context.sizeWidth(1),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: context.sizeWidth(0.1),
          child: const Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: TagoDark.textBold,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: context.theme.textTheme.titleMedium,
              ).padOnly(bottom: 10),
              Text(
                subtitle,
                style: context.theme.textTheme.bodyMedium,
                textAlign: TextAlign.left,
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                ),
              ).padOnly(bottom: 3),
              Text(
                subtitle2,
                style: context.theme.textTheme.bodyMedium,
                textAlign: TextAlign.left,
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: context.sizeWidth(0.3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onEdit,
                child: const Icon(
                  Icons.mode_edit_outline_outlined,
                  size: 22,
                  color: TagoLight.textBold,
                ),
              ).padOnly(right: 15),
              GestureDetector(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete,
                  size: 20,
                  color: TagoLight.textBold,
                ),
              )
            ],
          ),
        ),
      ]),
    ),
  );
}

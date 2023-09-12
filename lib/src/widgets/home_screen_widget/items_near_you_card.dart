import 'package:tago/app.dart';

Widget itemsNearYouCard({
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
          child: cachedNetworkImageWidget(
            imgUrl: image,
            height: 140,
          ),
        ),
        Text(
          TextConstant.acceptRequest,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: context.theme.textTheme.labelMedium?.copyWith(
            fontSize: 12,
            fontWeight: AppFontWeight.w500,
            fontFamily: TextConstant.fontFamilyNormal,
          ),
        ).padSymmetric(vertical: 8),
        Text(
          '${TextConstant.nairaSign} 1,000',
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

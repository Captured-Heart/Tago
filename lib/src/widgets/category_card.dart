import '../../app.dart';

Widget categoryCard({
  required BuildContext context,
  required int index,
  required double width,
  required double height,
}) {
  return SizedBox(
    width: width,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          categoriesFrame[index],
          height: height,
          // width: 100,
          fit: BoxFit.fill,
        ).padOnly(bottom: 4),
        Text(
          categoriesFooters[index],
          textAlign: TextAlign.center,
          maxLines: 2,
          softWrap: true,
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontSize: 12,
            overflow: TextOverflow.ellipsis,
            fontFamily: TextConstant.fontFamilyBold,
          ),
        )
      ],
    ),
  );
}

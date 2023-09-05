import 'package:tago/app.dart';

Widget categoryCard({
  required BuildContext context,
  required int index,
  required double width,
  required double height,
  CategoriesModel? categoriesModel,
}) {
  return SizedBox(
    width: width,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        cachedNetworkImageWidget(
          imgUrl: categoriesModel!.image?.entries.single.value ?? '',
          height: height,
        ).padOnly(bottom: 4),
        Text(
          categoriesModel.name!.isNotEmpty
              ? categoriesModel.name!
              : 'Not available',
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
  ).padOnly(right: 8);
}

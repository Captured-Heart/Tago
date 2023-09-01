import 'package:cached_network_image/cached_network_image.dart';

import '../../app.dart';

Widget subCategoryCard({
  required BuildContext context,
  required int index,
  required double width,
  required double height,
  required List<dynamic> subCategoriesModel,
}) {
  var subCategory =
      convertDynamicListToSubCategoryListModel(subCategoriesModel);
  return SizedBox(
    width: width,
    child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          cachedNetworkImageWidget(
            imgUrl: subCategory[index].image?.values.single,
            height: height,
          ),
          // CachedNetworkImage(
          //   imageUrl: subCategory[index].image?.values.single,
          //   // ??
          //   // subCategoriesModel[index]['imgUrl'],
          //   height: height,
          //   // width: 100,
          //   fit: BoxFit.fill,
          //   imageBuilder: (context, imageProvider) {
          //     return Container(
          //       decoration: BoxDecoration(
          //         shape: BoxShape.rectangle,
          //         image: DecorationImage(
          //           image: imageProvider,
          //           fit: BoxFit.fill,
          //         ),
          //       ),
          //     );
          //   },
          //   progressIndicatorBuilder: (context, string, progress) {
          //     return Center(
          //       child: CircularProgressIndicator(
          //         color: Theme.of(context).primaryColor,
          //         value: progress.progress,
          //       ),
          //     );
          //   },
          //   errorWidget: (context, url, error) {
          //     return Container(
          //       decoration: const BoxDecoration(
          //         shape: BoxShape.circle,
          //         image: DecorationImage(
          //           //TODO: ADD AN ERROR IMAGE FOR WIDGET
          //           image: AssetImage(logoLarge),
          //           fit: BoxFit.fill,
          //         ),
          //       ),
          //     );
          //   },
          // ).padOnly(bottom: 4),
          Text(
            subCategory[index].name!,
            textAlign: TextAlign.center,
            maxLines: 2,
            softWrap: true,
            style: context.theme.textTheme.bodyMedium?.copyWith(
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
              fontFamily: TextConstant.fontFamilyBold,
            ),
          )
        ]),
  );
}

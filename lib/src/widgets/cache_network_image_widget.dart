import 'package:tago/app.dart';

CachedNetworkImage cachedNetworkImageWidget({
  CategoriesModel? categoriesModel,
  required String imgUrl,
  required double height,
  // double? loaderHeight,
  double? loaderWidth,
}) {
  return CachedNetworkImage(
    imageUrl: imgUrl,
    height: height,
    // width: 100,
    fit: BoxFit.fill,
    imageBuilder: (context, imageProvider) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      );
    },
    progressIndicatorBuilder: (context, string, progress) {
      return Shimmer.fromColors(
        baseColor: TagoLight.indicatorActiveColor.withOpacity(0.2),
        highlightColor: TagoLight.indicatorInactiveColor,
        child: Container(
          alignment: Alignment.center,
          height: height,
          width: context.sizeWidth(1),
          color: TagoLight.indicatorActiveColor,
        ),
      );
    },
    errorWidget: (context, url, error) {
      return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage(noImagePlaceholder),
            fit: BoxFit.fill,
          ),
        ),
      );
    },
  );
}

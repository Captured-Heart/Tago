import 'package:tago/app.dart';
import 'package:tago/src/widgets/shimmer_widget.dart';

CachedNetworkImage cachedNetworkImageWidget({
  CategoriesModel? categoriesModel,
  required String? imgUrl,
  required double height,
  double? width,
  // double? loaderHeight,
  // double? loaderWidth,
}) {
  return CachedNetworkImage(
    imageUrl: imgUrl ?? noImagePlaceholderHttp,
    height: height,
    width: width,
    fit: BoxFit.fill,
    // imageBuilder: (context, imageProvider) {
    //   return Container(
    //     decoration: BoxDecoration(
    //       shape: BoxShape.rectangle,
    //       image: DecorationImage(
    //         image: NetworkImage(imgUrl ?? noImagePlaceholderHttp),
    //         fit: BoxFit.fill,
    //       ),
    //     ),
    //   );
    // },
    progressIndicatorBuilder: (context, string, progress) {
      return shimmerWidget(
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

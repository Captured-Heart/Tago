import 'package:tago/app.dart';
import 'package:tago/src/widgets/shimmer_widget.dart';

CachedNetworkImage cachedNetworkImageWidget({
  CategoriesModel? categoriesModel,
  required String? imgUrl,
  required double height,
  double? width,
  bool? isProgressIndicator = false,
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
      return isProgressIndicator == true
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : shimmerWidget(
              child: Container(
                alignment: Alignment.center,
                height: height,
                width: width ?? context.sizeWidth(1),
                color: TagoLight.indicatorActiveColor,
              ),
            );
    },
    errorWidget: (context, url, error) {
      return Container(
        width: width,
        height: height,
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

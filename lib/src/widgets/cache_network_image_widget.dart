import 'package:tago/app.dart';

CachedNetworkImage cachedNetworkImageWidget({
  CategoriesModel? categoriesModel,
  required String imgUrl,
  required double height,
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
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          value: progress.progress,
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

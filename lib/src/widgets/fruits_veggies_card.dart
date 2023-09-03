import 'package:tago/app.dart';
import 'package:tago/src/widgets/shimmer_widget.dart';

Widget getFreeDeliveryDesign(List<int> indexList, int index, BuildContext context) {
  if (indexList.contains(index)) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: const BoxDecoration(
            color: TagoLight.orange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
            )),
        child: Text(
          'Free delivery',
          style: context.theme.textTheme.labelMedium?.copyWith(
              color: TagoLight.scaffoldBackgroundColor, fontFamily: TextConstant.fontFamilyBold),
        ).padAll(5),
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}

Column fruitsAndVeggiesCard({
  required int index,
  required BuildContext context,
  bool? isFreeDelivery,
  List<int>? indexList,
  List<dynamic>? productImagesList,
  required ProductsModel productModel,
}) {
  // var products = convertDynamicListToProductListModel(productImagesList!);
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Card(
        elevation: 0.3,
        child: Stack(
          children: [
            // ElevatedButton(
            //     onPressed: () {
            //       log(productImagesList.toString());
            //     },
            //     child: Text('debug')),
            cachedNetworkImageWidget(
              imgUrl: productImagesList!.first['image']['url'],
              height: 140,
            ),
            getFreeDeliveryDesign(
              indexList ?? [],
              index,
              context,
            ),
            Positioned(
              // alignment: Alignment.bottomRight,
              bottom: 10,
              right: -1,
              child: addMinusBTN(
                context: context,
                onTap: () {},
                isMinus: false,
              ),
            )
          ],
        ),
      ),
      Text(
        productModel.name ?? '',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: context.theme.textTheme.labelMedium?.copyWith(
          fontSize: 12,
          fontWeight: AppFontWeight.w400,
          fontFamily: TextConstant.fontFamilyNormal,
        ),
      ).padSymmetric(vertical: 8),
      Text(
        'N${productModel.amount}',
        style: context.theme.textTheme.titleMedium?.copyWith(
          fontFamily: TextConstant.fontFamilyNormal,
          fontSize: 12,
        ),
        textAlign: TextAlign.start,
      )
    ],
  );
}

Widget addMinusBTN({
  bool? isMinus,
  required BuildContext context,
  required VoidCallback onTap,
  bool? isDelete,
}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      elevation: 0,
      shadowColor: Colors.transparent,
      visualDensity: VisualDensity.compact,
      fixedSize: const Size.fromRadius(15),
      minimumSize: const Size.fromRadius(15),
      padding: EdgeInsets.zero,
      backgroundColor:
          isMinus == true ? TagoLight.primaryColor.withOpacity(0.15) : TagoLight.primaryColor,
    ),
    child: Icon(
      isDelete == true
          ? Symbols.delete
          : isMinus == true
              ? Icons.remove
              : Icons.add,
      color: isMinus == true ? TagoDark.primaryColor : TagoDark.scaffoldBackgroundColor,
      size: 22,
    ),
  );
}

Widget fruitsAndVeggiesCardLoader({
  required BuildContext context,
}) {
  // var products = convertDynamicListToProductListModel(productImagesList!);
  return shimmerWidget(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0.3,
          child: Stack(
            children: [
              Container(
                height: 140,
                // color: TagoLight.indicatorActiveColor,
              ),
              Positioned(
                // alignment: Alignment.bottomRight,
                bottom: 10,
                right: -1,
                child: addMinusBTN(
                  context: context,
                  onTap: () {},
                  isMinus: false,
                ),
              )
            ],
          ),
        ),
        Text(
          'Product',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: context.theme.textTheme.labelMedium?.copyWith(
            fontSize: 12,
            fontWeight: AppFontWeight.w400,
            fontFamily: TextConstant.fontFamilyNormal,
          ),
        ).padSymmetric(vertical: 8),
        Text(
          'N-Amount',
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

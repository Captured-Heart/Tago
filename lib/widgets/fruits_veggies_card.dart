import 'package:tago/app.dart';
import 'package:tago/utils/extensions/debug_frame.dart';

Widget getFreeDeliveryDesign(
    List<int> indexList, int index, BuildContext context) {
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
              color: TagoLight.scaffoldBackgroundColor,
              fontFamily: TextConstant.fontFamilyBold),
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
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Card(
        elevation: 0.3,
        child: Stack(
          children: [
            Image.asset(
              categoriesFrame[index],
              height: 140,
              width: context.sizeWidth(1),
              fit: BoxFit.fill,
            ).padOnly(bottom: 4),
            getFreeDeliveryDesign(indexList ?? [], index, context),
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
        categoriesFooters[index],
        textAlign: TextAlign.center,
        style: context.theme.textTheme.labelMedium?.copyWith(
          fontSize: 12,
          fontWeight: AppFontWeight.w400,
          fontFamily: TextConstant.fontFamilyNormal,
        ),
      ).padSymmetric(vertical: 8),
      Text(
        'N1,400',
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
}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      elevation: 0,
      shadowColor: Colors.transparent,
      visualDensity: VisualDensity.compact,
      fixedSize: Size.fromRadius(15),
      minimumSize: const Size.fromRadius(15),
      padding: EdgeInsets.zero,
      backgroundColor: isMinus == true
          ? TagoLight.primaryColor.withOpacity(0.2)
          : TagoLight.primaryColor,
    ),
    child: Icon(
      isMinus == true ? Icons.remove : Icons.add,
      color: isMinus == true
          ? TagoDark.primaryColor
          : TagoDark.scaffoldBackgroundColor,
    ),
  );
}

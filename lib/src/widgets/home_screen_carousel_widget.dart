import 'package:tago/app.dart';

List<Widget> carouselWidgetList(BuildContext context) {
  return [
    hotDealsCarouselWidget(
      context: context,
      title: TextConstant.upto33percent,
      subTitle: TextConstant.getupto33percent,
      btnText: TextConstant.shopelectronics,
      onTapBtn: () {},
    ).padSymmetric(horizontal: 20),
    hotDealsCarouselWidget(
      context: context,
      title: TextConstant.tagoTreasureHunt,
      subTitle: TextConstant.findTheHiddenItems,
      onTapBtn: () {},
      btnText: TextConstant.startSearching,
    ).padSymmetric(horizontal: 20),
    hotDealsCarouselWidget(
      context: context,
      title: TextConstant.newArrivals,
      subTitle: TextConstant.checkOutHomeEssentials,
      onTapBtn: () {},
      btnText: TextConstant.browseHomeEssentials,
      isOrange: true,
    ).padSymmetric(horizontal: 20),
  ];
}

Widget hotDealsCarouselWidget({
  required BuildContext context,
  required String title,
  required String subTitle,
  required String btnText,
  required VoidCallback onTapBtn,
  bool? isOrange = false,
}) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: context.sizeWidth(1),
        decoration: BoxDecoration(
            color: TagoLight.textFieldFilledColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.theme.textTheme.titleLarge,
              textAlign: TextAlign.left,
            ),
            Text(
              subTitle,
              style: context.theme.textTheme.titleLarge?.copyWith(
                fontSize: 12,
                fontWeight: AppFontWeight.w400,
              ),
              textAlign: TextAlign.left,
            ),
            ElevatedButton(
              onPressed: onTapBtn,
              style: context.theme.elevatedButtonTheme.style?.copyWith(
                fixedSize: const MaterialStatePropertyAll<Size>(
                  Size.fromHeight(38),
                ),
                backgroundColor: isOrange == true
                    ? const MaterialStatePropertyAll<Color>(TagoLight.orange)
                    : const MaterialStatePropertyAll<Color>(
                        TagoLight.primaryColor),
              ),
              child: Text(btnText),
            )
          ].columnInPadding(15),
        ),
      )
    ],
  );
}

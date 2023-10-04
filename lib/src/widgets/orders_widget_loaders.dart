import 'package:tago/app.dart';

Widget orderWidgetLoaders(BuildContext context) {
  return shimmerWidget(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.1),
        ),
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: TagoLight.indicatorActiveColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstant.product,
                  style:
                      context.theme.textTheme.titleMedium?.copyWith(fontWeight: AppFontWeight.w300),
                ).padOnly(bottom: 5),
                Text('${TextConstant.orderID}: ${'1111111'}',
                    style: context.theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: AppFontWeight.w600)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  width: 80,
                  height: 25,
                  decoration: const BoxDecoration(color: TagoLight.indicatorActiveColor),
                ),
              ].columnInPadding(10),
            ),
          ),
        ],
      ),
    ),
  );
}

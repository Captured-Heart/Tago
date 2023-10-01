import 'package:tago/app.dart';

Widget categoryCardLoaders({
  required BuildContext context,
}) {
  return Wrap(
    runSpacing: 20,
    spacing: 10,
    alignment: WrapAlignment.start,
    // runAlignment: WrapAlignment.start,
    crossAxisAlignment: WrapCrossAlignment.start,
    children: List.generate(
      4,
      (index) => shimmerWidget(
        child: SizedBox(
          width: 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: TagoLight.indicatorActiveColor,
                ),
                height: 85,
                padding: const EdgeInsets.all(8),
              ).padOnly(bottom: 4),
              Text(
                ' Categories',
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
        ),
      ),
    ),
  );
}

Widget hotDealsLoaders({
  required BuildContext context,
}) {
  return SizedBox(
    height: 200,
    child: ListView.builder(
      itemCount: 3,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return shimmerWidget(
          child: Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            width: context.sizeWidth(0.9),
            decoration: BoxDecoration(
                color: TagoLight.indicatorActiveColor, borderRadius: BorderRadius.circular(20)),
          ).padOnly(bottom: 4),
        );
      },
    ),
  );
}

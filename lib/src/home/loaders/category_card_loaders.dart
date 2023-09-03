import 'package:tago/app.dart';
import 'package:tago/src/widgets/shimmer_widget.dart';

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
      9,
      (index) => shimmerWidget(
        child: SizedBox(
          width: context.sizeWidth(0.155),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 70,
                color: TagoLight.indicatorActiveColor,
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

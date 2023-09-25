import 'package:tago/app.dart';

Row customStepperWidget({
    required BuildContext context,
    required IconData iconData,
    required String title,
    required String subtitle,
    bool? isFaded = false,
    bool hideDash = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              iconData,
              color: isFaded == true
                  ? TagoLight.indicatorActiveColor
                  : TagoLight.primaryColor,
            ),
            !hideDash
                ? const Dash(
                    length: 40,
                    dashLength: 6,
                    direction: Axis.vertical,
                    dashColor: TagoLight.indicatorActiveColor,
                  ).padSymmetric(vertical: 5)
                : const SizedBox.shrink()
          ].columnInPadding(5),
        ),
        Expanded(
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        color: isFaded == true
                            ? TagoLight.indicatorActiveColor
                            : null,
                      ),
                    ),
                    SizedBox(
                      width: context.sizeWidth(0.65),
                      child: Text(
                        subtitle,
                        maxLines: 2,
                        style: context.theme.textTheme.titleSmall?.copyWith(
                          fontWeight: AppFontWeight.w100,
                          color: isFaded == true
                              ? TagoLight.indicatorActiveColor
                              : null,
                        ),
                      ),
                    )
                  ].columnInPadding(5))
              .padOnly(top: 4, left: 10),
        )
      ],
    );
  }

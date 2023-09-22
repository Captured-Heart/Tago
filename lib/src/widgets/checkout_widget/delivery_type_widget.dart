import 'package:tago/app.dart';

Row deliveryTypeRowButtons({
  required BuildContext context,
  // required Function setState,
  required VoidCallback onTapScheduleDelivering,
  required VoidCallback onTapInstantSchedule,
  required bool isInstant,
}) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTapInstantSchedule,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isInstant == true
                    ? TagoLight.orange
                    : TagoLight.textFieldBorder,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Symbols.bolt_rounded,
                    color: TagoLight.scaffoldBackgroundColor,
                    size: 17,
                  ),
                  Expanded(
                    child: Text(
                      TextConstant.instantDelivering,
                      maxLines: 1,
                      style: context.theme.textTheme.bodySmall
                          ?.copyWith(color: TagoLight.scaffoldBackgroundColor),
                    ),
                  ),
                ].rowInPadding(5),
              ),
            ),
          ),
        ),

        //schedule for later
        Expanded(
          child: GestureDetector(
            onTap: onTapScheduleDelivering,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isInstant == true
                    ? TagoLight.textFieldBorder
                    : TagoLight.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Symbols.schedule,
                    color: TagoLight.scaffoldBackgroundColor,
                    size: 17,
                  ),
                  Expanded(
                    child: Text(
                      TextConstant.scheduleforLater,
                      maxLines: 1,
                      style: context.theme.textTheme.bodySmall
                          ?.copyWith(color: TagoLight.scaffoldBackgroundColor),
                    ),
                  ),
                ].rowInPadding(5),
              ),
            ),
          ),
        ),
      ].rowInPadding(20));
}

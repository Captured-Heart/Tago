import 'package:tago/app.dart';
import 'package:tago/src/widgets/shimmer_widget.dart';

Widget savedAddressCardLoader({
  required BuildContext context,
}) {
  return shimmerWidget(
    child: Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      width: context.sizeWidth(1),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: context.sizeWidth(0.1),
          child: const Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: TagoDark.textBold,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LinearProgressIndicator(
                minHeight: 15,
              ),
              SizedBox(
                width: context.sizeWidth(0.2),
                child: const LinearProgressIndicator(
                  minHeight: 8,
                ),
              ).padSymmetric(vertical: 10),
              SizedBox(
                width: context.sizeWidth(0.2),
                child: const LinearProgressIndicator(
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: context.sizeWidth(0.3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.mode_edit_outline_outlined,
                size: 22,
                color: TagoLight.textBold,
              ).padOnly(right: 15),
              const Icon(
                Icons.delete,
                size: 20,
                color: TagoLight.textBold,
              )
            ],
          ),
        ),
      ]),
    ),
  );
}

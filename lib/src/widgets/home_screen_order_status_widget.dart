import 'package:tago/app.dart';

Widget homeScreenOrderStatusWidget(
    {required BuildContext context, required WidgetRef ref}) {
  return Container(
    decoration: const BoxDecoration(
      color: TagoLight.textFieldFilledColor,
      border: Border(bottom: BorderSide(width: 0.1)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                TextConstant.activeOrderstatus,
                style: context.theme.textTheme.bodyLarge,
              ),
            ),
            Chip(
                label: const Text(
                  TextConstant.pickedup,
                  style: TextStyle(color: TagoDark.primaryColor),
                ),
                shape: const ContinuousRectangleBorder(),
                backgroundColor: TagoLight.primaryColor.withOpacity(0.1))
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                TextConstant.remainingTime,
                style: context.theme.textTheme.bodyLarge,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: TagoDark.primaryColor,
                ).padOnly(right: 5),
                Text(
                  '12 minutes away',
                  style: context.theme.textTheme.bodyLarge,
                )
              ],
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            // ignore: invalid_use_of_protected_member
            ref.read(scaffoldKeyProvider).currentState!.setState(() {
              Scaffold.of(context).openDrawer();
            });
          },
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: const Text(
            TextConstant.viewOrderdetails,
            textAlign: TextAlign.start,
          ),
        )
      ],
    ),
  );
}

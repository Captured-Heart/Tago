import 'package:tago/app.dart';

Widget ratingsCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: const BoxDecoration(
        border: Border(
      bottom: BorderSide(width: 0.1),
    )),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: TagoLight.orange),
                  Text(
                    '4.5',
                    style: context.theme.textTheme.bodyLarge,
                  ),
                ].rowInPadding(5)),
            Text(
              'Nice Drink',
              style: context.theme.textTheme.titleMedium,
            ),
            SizedBox(
              width: context.sizeWidth(0.6),
              child: Text(
                'I loved it so much. It’s a worthy buy I loved it so much. It’s a worthy buy...I loved it so much. It’s a worthy buy...',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: context.theme.textTheme.bodyMedium,
              ),
            ),
          ].columnInPadding(10),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'by Kenneth',
              // style: context.theme.textTheme.bodySmall,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                TextConstant.verifiedPurchase,
                style: AppTextStyle.buttonTextTextstyleLight.copyWith(
                  color: TagoLight.primaryColor,
                  fontFamily: TextConstant.fontFamilyLight,
                  fontSize: 12,
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

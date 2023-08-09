import 'package:tago/app.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.notifications,
        isLeading: true,
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            notificationListTile(
              context: context,
              isReceipt: true,
              title: "Order Confirmed",
            ),
            notificationListTile(
              context: context,
              isReceipt: false,
              title: "Welcome to Tago",
            ),
          ]),
    );
  }

  ListTile notificationListTile({
    required BuildContext context,
    required bool isReceipt,
    required String title,
  }) {
    return ListTile(
        minVerticalPadding: 15,
        minLeadingWidth: 10,
        isThreeLine: true,
        shape: const Border(bottom: BorderSide(width: 0.1)),
        leading: Icon(
          isReceipt == true ? Icons.receipt : Icons.confirmation_num_outlined,
          color: isReceipt == true ? TagoLight.primaryColor : TagoLight.orange,
          size: 25,
        ),
        title: Text(title),
        subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      style: context.theme.textTheme.bodySmall,
                      children: [
                        const TextSpan(text: 'Your order for '),
                        TextSpan(
                            text: 'Coca-cola drink - pack of 6 can',
                            style: context.theme.textTheme.titleSmall),
                        const TextSpan(
                            text:
                                ' was received by our fulfilment centre and is being processed'),
                      ],
                    ),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Today',
                          style: context.theme.textTheme.bodyMedium,
                        ),
                        Text(
                          '.',
                          style: context.theme.textTheme.bodyMedium
                              ?.copyWith(height: 0.2),
                          textScaleFactor: 5,
                        ),
                        Text(
                          '12.02PM',
                          style: context.theme.textTheme.bodyMedium,
                        ),
                      ].rowInPadding(5))
                ].columnInPadding(10))
            .padSymmetric(vertical: 10));
  }
}

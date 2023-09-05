import 'package:tago/app.dart';

class MetricsScreen extends ConsumerStatefulWidget {
  const MetricsScreen({super.key});

  @override
  MetricsScreenState createState() => MetricsScreenState();
}

class MetricsScreenState extends ConsumerState<MetricsScreen> {
  String selectedItem = 'Today';

  List<String> dropdownItems = ['Today', 'Yesterday', '7 days', '30 days'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(
          context: context,
          title: TextConstant.metrics,
          isLeading: true,
          centerTitle: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(width: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                value: selectedItem,
                isDense: true,
                borderRadius: BorderRadius.circular(20),
                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                iconSize: 20,
                alignment: AlignmentDirectional.bottomCenter,
                elevation: 6,
                style: context.theme.textTheme.bodyLarge,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue!;
                  });
                },
                underline: const SizedBox.shrink(),
                items:
                    dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

//
            Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.1),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: metricsListTiles(
                                context: context,
                                title: TextConstant.successfulOrders,
                                value: 4,
                                subtitle: TextConstant.successful,
                              ),
                            ),
                            Expanded(
                              child: metricsListTiles(
                                context: context,
                                title: TextConstant.failedOrders,
                                value: 0,
                                subtitle: TextConstant.failed,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.1),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: metricsListTiles(
                                context: context,
                                title: TextConstant.distancecovered,
                                value: 200,
                                subtitle: TextConstant.km,
                              ),
                            ),
                            Expanded(
                              child: metricsListTiles(
                                context: context,
                                title: TextConstant.timeTraveled,
                                value: 256,
                                subtitle: TextConstant.minutes,
                              ),
                            ),
                          ],
                        ),
                      )
                    ].columnInPadding(10))
                .padSymmetric(vertical: 20)
          ],
        ).padAll(20));
  }

  ListTile metricsListTiles({
    required BuildContext context,
    required int value,
    required String subtitle,
    required String title,
  }) {
    return ListTile(
      title: Text(
        title,
        style: context.theme.textTheme.bodyLarge,
        textScaleFactor: 1.1,
      ).padOnly(bottom: 12),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$value',
            style: context.theme.textTheme.titleLarge,
            textScaleFactor: 1.3,
          ),
          Text(
            subtitle,
            style: context.theme.textTheme.bodyMedium,
            textScaleFactor: 1.1,
          ),
        ].rowInPadding(5),
      ),
    );
  }
}

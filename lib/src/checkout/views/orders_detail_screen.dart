import 'package:flutter_dash/flutter_dash.dart';
import 'package:tago/app.dart';

class OrdersDetailScreen extends ConsumerWidget {
  final List<Step> steps = const [
    Step(
        title: Text(TextConstant.orderPlaced),
        subtitle: Text(TextConstant.youWillReceiveAnEmail),
        content: SizedBox.shrink(),
        state: StepState.editing),
    Step(
        title: Text(TextConstant.orderPlaced),
        subtitle: Text(TextConstant.acceptRequest),
        content: Text('data'))
  ];

  const OrdersDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: ListView(
      children: [
        Text('data'),
        Container(
          height: 142,
          width: context.sizeWidth(1),
          color: TagoDark.orange,
        ),
        customStepperWidget(
          context: context,
          iconData: Icons.cloud_circle,
          title: TextConstant.orderPlaced,
          subtitle: TextConstant.youWillReceiveAnEmail,
        ),
        customStepperWidget(
          context: context,
          iconData: Icons.cloud_circle,
          title: TextConstant.orderPlaced,
          subtitle: TextConstant.youWillReceiveAnEmail,
        ),
        customStepperWidget(
          context: context,
          iconData: Icons.cloud_circle,
          title: TextConstant.orderPlaced,
          subtitle: TextConstant.youWillReceiveAnEmail,
        ),

        // Stepper(
        //   steps: steps,
        //   type: StepperType.vertical,
        //   stepIconBuilder: (stepIndex, stepState) {
        //     return Column(
        //       children: List.generate(stepIndex, (index) => Icon(Icons.abc)),
        //     );
        //   },
        // )
      ],
    ).padAll(20));
  }

  Container customStepperWidget({
    required BuildContext context,
    required IconData iconData,
    required String title,
    required String subtitle,
  }) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                iconData,
                color: TagoLight.primaryColor,
              ),
              Dash(
                length: 40,
                dashLength: 6,
                direction: Axis.vertical,
                dashColor: TagoLight.indicatorActiveColor,
              ),
            ].columnInPadding(5),
          ),
          Expanded(
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.theme.textTheme.titleMedium,
                      ),
                      Text(
                        subtitle,
                        maxLines: 2,
                        style: context.theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: AppFontWeight.w100),
                      )
                    ].columnInPadding(5))
                .padOnly(top: 4, left: 10),
          )
        ],
      ),
    );
  }
}

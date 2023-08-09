import 'package:tago/app.dart';

class ReferAndEarn extends ConsumerWidget {
  const ReferAndEarn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.referandEarn,
        isLeading: true,
      ),
    );
  }
}

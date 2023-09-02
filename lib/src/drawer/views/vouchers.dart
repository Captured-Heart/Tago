import 'package:tago/app.dart';

class MyVouchers extends ConsumerWidget {
  const MyVouchers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.myvouchers,
        isLeading: true,
      ),
      body: Center(
        heightFactor: 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.confirmation_num_outlined,
              size: 84,
              color: TagoLight.textHint,
            ),
            ConstrainedBox(
              constraints:
                  BoxConstraints.tight(Size(context.sizeWidth(0.5), 100)),
              child: Text(
                TextConstant.vouchersWillAppear,
                textAlign: TextAlign.center,
                style: context.theme.textTheme.titleLarge?.copyWith(
                  fontWeight: AppFontWeight.w100,
                  fontFamily: TextConstant.fontFamilyLight,
                ),
              ),
            )
          ].columnInPadding(20),
        ),
      ),
    );
  }
}

import 'package:tago/app.dart';

class AddNewCardsScreen extends ConsumerStatefulWidget {
  const AddNewCardsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewCardsScreenState();
}

class _AddNewCardsScreenState extends ConsumerState<AddNewCardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.addnewCard,
        isLeading: true,
      ),
      body: Column(
        // padding: const EdgeInsets.symmetric(horizontal: 22),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstant.nameonCard,
                  style: context.theme.textTheme.bodySmall,
                ),
                authTextFieldWithError(
                  controller: TextEditingController(),
                  context: context,
                  isError: false,
                  hintText: TextConstant.firstandlastname,
                ),
              ].columnInPadding(8)),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstant.cardNumber,
                  style: context.theme.textTheme.bodySmall,
                ),
                authTextFieldWithError(
                  controller: TextEditingController(),
                  context: context,
                  isError: false,
                  hintText: TextConstant.cardNumberHint,
                ),
              ].columnInPadding(8)),
          Row(
              children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TextConstant.expiryDate,
                    style: context.theme.textTheme.bodySmall,
                  ),
                  authTextFieldWithError(
                    controller: TextEditingController(),
                    context: context,
                    isError: false,
                    hintText: TextConstant.mmAndyy
                  ),
                ].columnInPadding(8),
              ),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextConstant.cvv,
                      style: context.theme.textTheme.bodySmall,
                    ),
                    authTextFieldWithError(
                      controller: TextEditingController(),
                      context: context,
                      hintText: '123',
                      isError: false,
                    ),
                  ].columnInPadding(8)),
            )
          ].rowInPadding(20)),
          const Spacer(),
          SizedBox(
            width: context.sizeWidth(1),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(TextConstant.done),
            ),
          ).padOnly(bottom: 30)
        ],
      ).padAll(20),
    );
  }
}

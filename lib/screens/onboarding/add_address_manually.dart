import 'package:tago/app.dart';

class AddAddressManuallyScreen extends ConsumerWidget {
  static const String routeName = 'add address2';
  const AddAddressManuallyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: appBarWidget(
          context: context,
          title: TextConstant.addAdress,
          suffixIcon: TextButton(
              onPressed: () {}, child: const Text(TextConstant.skip)),
        ),
        body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  authTextFieldWithError(
                    controller: TextEditingController(),
                    context: context,
                    isError: false,
                    hintText: TextConstant.streetAddress,
                  ),
                  authTextFieldWithError(
                    controller: TextEditingController(),
                    context: context,
                    isError: false,
                    hintText: TextConstant.apartmentFloorno,
                  ),
                  authTextFieldWithError(
                    controller: TextEditingController(),
                    context: context,
                    isError: false,
                    hintText: TextConstant.city,
                  ),
                  Row(children: [
                    Expanded(
                        child: authTextFieldWithError(
                      controller: TextEditingController(),
                      context: context,
                      isError: false,
                      hintText: TextConstant.state,
                    ).padOnly(right: 15)),
                    Expanded(
                      child: authTextFieldWithError(
                        controller: TextEditingController(),
                        context: context,
                        isError: false,
                        hintText: TextConstant.postalcode,
                      ),
                    ),
                  ]),
                  Text(
                    TextConstant.thishelpsTagotofind,
                    style: context.theme.textTheme.bodyMedium,
                  ).padOnly(top: 10),
                  Align(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on, size: 15),
                      label: const Text(TextConstant.usemycurrentlocation),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: context.sizeWidth(1),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(TextConstant.save),
                    ),
                  ).padOnly(bottom: 16)
                ].columnInPadding(10))
            .padAll(20));
  }
}

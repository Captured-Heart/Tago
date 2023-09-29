import 'package:tago/app.dart';

class AddAddressManuallyScreen extends ConsumerStatefulWidget {
  static const String routeName = 'add address2';
  const AddAddressManuallyScreen({super.key});

  @override
  ConsumerState<AddAddressManuallyScreen> createState() => _AddAddressManuallyScreenState();
}

class _AddAddressManuallyScreenState extends ConsumerState<AddAddressManuallyScreen> {
  final TextEditingControllerClass controller = TextEditingControllerClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.addAdress,
        suffixIcon: TextButton(
          onPressed: () {
            pushReplacement(
              context,
              const MainScreen(),
            );
          },
          child: const Text(TextConstant.skip),
        ),
      ),
      body: Form(
        key: controller.signInformKey,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            authTextFieldWithError(
              controller: controller.addressStreetController,
              context: context,
              isError: false,
              hintText: TextConstant.streetAddress,
              inputFormatters: [],
              validator: RequiredValidator(errorText: requiredValue),
            ),
            authTextFieldWithError(
              controller: controller.apartmentNoController,
              context: context,
              isError: false,
              hintText: TextConstant.apartmentFloorno,
              inputFormatters: [],
              validator: RequiredValidator(errorText: requiredValue),
            ),
            authTextFieldWithError(
              controller: controller.addressCityController,
              context: context,
              isError: false,
              hintText: TextConstant.city,
              inputFormatters: [],
              validator: RequiredValidator(errorText: requiredValue),
            ),
            Row(children: [
              Expanded(
                  child: authTextFieldWithError(
                controller: TextEditingController(),
                context: context,
                isError: false,
                hintText: TextConstant.state,
                inputFormatters: [],
                validator: RequiredValidator(errorText: requiredValue),
              ).padOnly(right: 15)),
              Expanded(
                child: authTextFieldWithError(
                  controller: TextEditingController(),
                  context: context,
                  isError: false,
                  hintText: TextConstant.postalcode,
                  inputFormatters: [],
                  validator: RequiredValidator(errorText: requiredValue),
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
                onPressed: () {
                  if (controller.signInformKey.currentState!.validate()) {
                    ref.read(accountAddressProvider.notifier).addAddressMethod(
                      map: {
                        AddressType.apartmentNumber.name: controller.apartmentNoController.text,
                        AddressType.city.name: controller.addressCityController.text,
                        AddressType.state.name: controller.addressLabelController.text,
                        AddressType.streetAddress.name: controller.addressStreetController.text
                      },
                      context: context,
                      ref: ref,
                      onNavigation: () {
                        pushReplacement(
                          context,
                          const MainScreen(),
                        );
                      },
                    );
                  }
                },
                child: const Text(TextConstant.save),
              ),
            ).padOnly(bottom: 16)
          ].columnInPadding(10),
        ).padAll(20),
      ),
    );
  }
}

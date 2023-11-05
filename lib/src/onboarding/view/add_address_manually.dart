// ignore_for_file: use_build_context_synchronously

import 'package:tago/app.dart';
import 'package:tago/src/onboarding/model/domain/address_res.dart';

class AddAddressManuallyScreen extends ConsumerStatefulWidget {
  static const String routeName = 'add address2';
  AddAddressManuallyScreen({
    super.key,
    this.addressData,
  });

  AddressSearchResponse? addressData;

  @override
  ConsumerState<AddAddressManuallyScreen> createState() =>
      _AddAddressManuallyScreenState();
}

class _AddAddressManuallyScreenState
    extends ConsumerState<AddAddressManuallyScreen> {
  final TextEditingControllerClass controller = TextEditingControllerClass();
  final FocusNode _focusNode = FocusNode();

  void initState() {
    ref.read(getCurrentLocationProvider);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      runAfterBuild();
    });
  }

  void runAfterBuild() {
    if (widget.addressData != null) {
      controller.addressStreetController.text =
          widget.addressData!.streetAddress ?? "";
      controller.addressCityController.text = widget.addressData!.city ?? "";
      controller.apartmentNoController.text =
          widget.addressData!.streetNumber.toString();
      controller.addressStateController.text = widget.addressData!.region ?? "";
      controller.addressPostalController.text =
          widget.addressData!.postal ?? "";
    }
  }

  void openSearchWidget(String? searchText) async {
    var prediction = await openGooglePlacesSearch(context, searchText);
    var addressRes = await getAddress(prediction);
    controller.addressStreetController.text = addressRes.streetAddress ?? "";
    controller.addressCityController.text = addressRes.city ?? "";
    controller.apartmentNoController.text = addressRes.streetNumber.toString();
    controller.addressStateController.text = addressRes.region ?? "";
    controller.addressPostalController.text = addressRes.postal ?? "";
    widget.addressData = addressRes;
  }

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
          shrinkWrap: false,
          children: [
            authTextFieldWithError(
              controller: controller.addressStreetController,
              context: context,
              isError: false,
              hintText: TextConstant.streetAddress,
              inputFormatters: [],
              validator: RequiredValidator(errorText: requiredValue),
              onChanged: (p0) {
                openSearchWidget(p0);
                _focusNode.unfocus();
              },
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
            SizedBox(
              width: context.sizeWidth(1),
              child: Row(
                children: [
                  Flexible(
                    child: authTextFieldWithError(
                      controller: controller.addressStateController,
                      context: context,
                      isError: false,
                      hintText: TextConstant.state,
                      inputFormatters: [],
                      validator: RequiredValidator(errorText: requiredValue),
                    ).padOnly(right: 15),
                  ),
                  Flexible(
                    child: authTextFieldWithError(
                      controller: controller.addressPostalController,
                      context: context,
                      isError: false,
                      hintText: TextConstant.postalcode,
                      inputFormatters: [],
                      validator: RequiredValidator(errorText: requiredValue),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              TextConstant.thishelpsTagotofind,
              style: context.theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ).padOnly(top: 10),
            Align(
              child: TextButton.icon(
                onPressed: () async {
                  final currentPosition = ref.watch(getCurrentLocationProvider);
                  var lat = currentPosition.asData!.value.latitude;
                  var lng = currentPosition.asData!.value.longitude;
                  var address = await getCurrentLocationAddress(lat, lng);
                  openSearchWidget(address.streetAddress);
                },
                icon: const Icon(Icons.location_on, size: 15),
                label: const Text(TextConstant.usemycurrentlocation),
              ),
            ),
            // const Spacer(),
            SizedBox(
              width: context.sizeWidth(1),
              child: ElevatedButton(
                onPressed: () {
                  if (controller.signInformKey.currentState!.validate()) {
                    ref.read(accountAddressProvider.notifier).addAddressMethod(
                      map: {
                        AddressType.apartmentNumber.name:
                            controller.apartmentNoController.text,
                        AddressType.city.name:
                            controller.addressCityController.text,
                        AddressType.state.name:
                            controller.addressStateController.text,
                        AddressType.streetAddress.name:
                            controller.addressStreetController.text,
                        AddressType.postalCode.name:
                            controller.addressPostalController.text,
                        AddressType.metadata.name:
                            jsonEncode(widget.addressData!.toJson())
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

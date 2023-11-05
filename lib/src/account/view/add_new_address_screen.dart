import 'package:tago/app.dart';
import 'package:tago/src/onboarding/model/domain/address_res.dart';

class AddNewAddressScreen extends ConsumerStatefulWidget {
  const AddNewAddressScreen({
    super.key,
    this.addressModel,
    this.isEditMode = false,
  });
  final AddressModel? addressModel;
  final bool? isEditMode;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends ConsumerState<AddNewAddressScreen> {
  @override
  void initState() {
    ref.read(getCurrentLocationProvider);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      runAfterBuild();
    });
  }

  void runAfterBuild() {
    if (widget.addressModel != null) {
      addressStreetController.text = widget.addressModel!.streetAddress!;
      addressCityController.text = widget.addressModel!.city!;
      apartmentNoController.text = widget.addressModel!.apartmentNumber!;
      addressStateController.text = widget.addressModel!.state!;
    }
  }

  AddressSearchResponse? addressData;

  void openSearchWidget(String? searchText) async {
    var prediction = await openGooglePlacesSearch(context, searchText);
    var addressRes = await getAddress(prediction);
    controller.addressStreetController.text = addressRes.description ?? "";
    controller.addressCityController.text = addressRes.city ?? "";
    controller.apartmentNoController.text = addressRes.streetNumber.toString();
    controller.addressStateController.text = addressRes.region ?? "";
    controller.addressPostalController.text = addressRes.postal ?? "";
    // editable
    addressStreetController.text = addressRes.description ?? "";
    addressCityController.text = addressRes.city ?? "";
    apartmentNoController.text = addressRes.streetNumber.toString();
    addressStateController.text = addressRes.region ?? "";
    addressPostalController.text = addressRes.postal ?? "";
    addressData = addressRes;
  }

  final ScrollController scrollController = ScrollController();
  final TextEditingControllerClass controller = TextEditingControllerClass();

  TextEditingController addressStreetController = TextEditingController();
  TextEditingController addressCityController = TextEditingController();
  TextEditingController apartmentNoController = TextEditingController();
  TextEditingController addressStateController = TextEditingController();
  TextEditingController addressPostalController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final currentPosition = ref.watch(getCurrentLocationProvider);

    return FullScreenLoader(
      isLoading: ref.watch(accountAddressProvider).isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBarWidget(
          context: context,
          title: TextConstant.addnewAddress,
          isLeading: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: controller.signInformKey,
              child: Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  interactive: true,
                  child: ListView(
                    controller: scrollController,
                    children: [
                      //

                      SizedBox(
                        height: context.sizeHeight(0.20),
                        child: GoogleMap(
                          mapType: MapType.terrain,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              currentPosition.valueOrNull?.latitude ?? 20,
                              currentPosition.valueOrNull?.longitude ?? 12.2,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextConstant.addressDetails,
                            textAlign: TextAlign.left,
                            style: context.theme.textTheme.bodyLarge,
                          ),
                          authTextFieldWithError(
                            controller: widget.isEditMode == false
                                ? controller.addressStreetController
                                : addressStreetController,
                            context: context,
                            isError: false,
                            inputFormatters: [],
                            focusNode: _focusNode,
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                            hintText: TextConstant.enterAnewAddress,
                            onChanged: (p0) {
                              openSearchWidget(p0);
                              _focusNode.unfocus();
                            },
                            validator:
                                RequiredValidator(errorText: requiredValue),
                          ),
                          Row(children: [
                            Flexible(
                              child: authTextFieldWithError(
                                controller: widget.isEditMode == false
                                    ? controller.apartmentNoController
                                    : apartmentNoController,
                                context: context,
                                isError: false,
                                hintText: TextConstant.appartmentsuite,
                                validator:
                                    RequiredValidator(errorText: requiredValue),
                              ),
                            ),
                            Flexible(
                              child: authTextFieldWithError(
                                controller: widget.isEditMode == false
                                    ? controller.addressPostalController
                                    : addressPostalController,
                                context: context,
                                isError: false,
                                hintText: TextConstant.postalcode,
                                validator:
                                    RequiredValidator(errorText: requiredValue),
                              ),
                            ),
                          ]),
                          authTextFieldWithError(
                            controller: widget.isEditMode == false
                                ? controller.addressCityController
                                : addressCityController,
                            context: context,
                            inputFormatters: [],
                            isError: false,
                            hintText: TextConstant.city,
                            validator:
                                RequiredValidator(errorText: requiredValue),
                          ),
                          authTextFieldWithError(
                            controller: widget.isEditMode == false
                                ? controller.addressStateController
                                : addressStateController,
                            context: context,
                            inputFormatters: [],
                            isError: false,
                            hintText: TextConstant.state,
                            validator:
                                RequiredValidator(errorText: requiredValue),
                          ),
                        ].columnInPadding(10),
                      ).padAll(20)
                    ],
                  ),
                ),
              ),
            ),
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
                    if (widget.isEditMode == false) {
                      log('entered the add address voidcallback');
                      ref
                          .read(accountAddressProvider.notifier)
                          .addAddressMethod(
                              map: {
                            AddressType.apartmentNumber.name: controller
                                .apartmentNoController.text
                                .toTitleCase(),
                            AddressType.city.name: controller
                                .addressCityController.text
                                .toTitleCase(),
                            AddressType.state.name: controller
                                .addressStateController.text
                                .toTitleCase(),
                            AddressType.streetAddress.name: controller
                                .addressStreetController.text
                                .toTitleCase(),
                            AddressType.postalCode.name: controller
                                .addressPostalController.text
                                .toTitleCase(),
                            AddressType.metadata.name: addressData != null
                                ? jsonEncode(addressData!.toJson())
                                : ""
                          },
                              context: context,
                              ref: ref,
                              onNavigation: () {
                                pop(context);
                                ref.invalidate(getAccountInfoProvider);
                              });
                    } else {
                      log('entered the edit address function');

                      ref
                          .read(accountAddressProvider.notifier)
                          .editAddressMethod(
                        map: {
                          AddressType.id.name:
                              widget.addressModel?.id.toString(),
                          AddressType.apartmentNumber.name:
                              apartmentNoController.text,
                          AddressType.city.name: addressCityController.text,
                          AddressType.state.name: addressCityController.text,
                          AddressType.streetAddress.name:
                              addressStreetController.text,
                          AddressType.postalCode.name:
                              addressPostalController.text,
                          AddressType.metadata.name: addressData != null
                              ? jsonEncode(addressData!.toJson())
                              : ""
                        },
                        context: context,
                        ref: ref,
                      );
                    }
                  }
                },
                child: const Text(TextConstant.saveandContinue),
              ),
            ).padAll(20)
          ],
        ),
      ),
    );
  }
}

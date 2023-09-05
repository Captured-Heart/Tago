import 'package:tago/app.dart';

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
  }

  final ScrollController scrollController = ScrollController();
  final TextEditingControllerClass controller = TextEditingControllerClass();

  @override
  Widget build(BuildContext context) {
    final currentPosition = ref.watch(getCurrentLocationProvider);
    TextEditingController addressStreetController =
        TextEditingController(text: widget.addressModel?.streetAddress);
    TextEditingController addressCityController =
        TextEditingController(text: widget.addressModel?.city);
    TextEditingController apartmentNoController =
        TextEditingController(text: widget.addressModel?.apartmentNumber);
    TextEditingController addressLabelController =
        TextEditingController(text: widget.addressModel?.label);
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
          // padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        height: context.sizeHeight(0.35),
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
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                            hintText: TextConstant.enterAnewAddress,
                            validator:
                                RequiredValidator(errorText: requiredValue),
                          ),
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
                                ? controller.apartmentNoController
                                : apartmentNoController,
                            context: context,
                            isError: false,
                            hintText: TextConstant.appartmentsuite,
                          ),
                          Text(
                            TextConstant.addressLabel,
                            textAlign: TextAlign.left,
                            style: context.theme.textTheme.bodyLarge,
                          ),
                          authTextFieldWithError(
                            controller: widget.isEditMode == false
                                ? controller.addressLabelController
                                : addressLabelController,
                            context: context,
                            isError: false,
                            inputFormatters: [],
                            textInputAction: TextInputAction.send,
                            hintText: TextConstant.egOffice,
                          ),
                        ].columnInPadding(10),
                      ).padAll(20)
                    ],
                  ),
                ),
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       log(widget.addressModel!.id!);
            //     },
            //     child: Text('debug')),
            //button
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
                          AddressType.apartmentNumber.name:
                              controller.apartmentNoController.text,
                          AddressType.city.name:
                              controller.addressCityController.text,
                          AddressType.state.name:
                              controller.addressLabelController.text,
                          AddressType.streetAddress.name:
                              controller.addressStreetController.text
                        },
                        context: context,
                        ref: ref,
                      );
                    } else {
                      log('entered the edit address function');

                      ref
                          .read(accountAddressProvider.notifier)
                          .editAddressMethod(
                        map: {
                          AddressType.postalCode.name:
                              widget.addressModel?.label.toString(),
                          AddressType.setAsDefault.name: 'false',
                          AddressType.id.name:
                              widget.addressModel?.id.toString(),
                          AddressType.apartmentNumber.name:
                              apartmentNoController.text,
                          AddressType.city.name: addressCityController.text,
                          AddressType.state.name: addressCityController.text,
                          AddressType.streetAddress.name:
                              addressStreetController.text
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

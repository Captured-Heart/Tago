import 'package:tago/app.dart';
import 'package:tago/config/utils/enums/address_type_enums.dart';
import 'package:tago/src/account/controller/address_notifier_provider.dart';

class AddNewAddressScreen extends ConsumerStatefulWidget {
  const AddNewAddressScreen({super.key});

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
                              currentPosition.value?.latitude ?? 20,
                              currentPosition.value?.longitude ?? 12.2,
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
                            controller: controller.addressStreetController,
                            context: context,
                            isError: false,
                            inputFormatters: [],
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                            hintText: TextConstant.enterAnewAddress,
                          ),
                          authTextFieldWithError(
                            controller: controller.addressCityController,
                            context: context,
                            isError: false,
                            hintText: TextConstant.city,
                          ),
                          authTextFieldWithError(
                            controller: controller.apartmentNoController,
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
                            controller: controller.addressLabelController,
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

            //button
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
                            controller.addressLabelController.text,
                        AddressType.streetAddress.name:
                            controller.addressStreetController.text
                      },
                      context: context,
                      ref: ref,
                    );
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

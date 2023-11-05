// ignore_for_file: use_build_context_synchronously

import 'package:tago/app.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  static const String routeName = 'add address';
  const AddAddressScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  var searchAddressController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ref.read(getCurrentLocationProvider);
  }

  void openSearchWidget(String? searchText) async {
    var prediction = await openGooglePlacesSearch(context, searchText);
    setState(() {
      isLoading = true;
    });
    var addressRes = await getAddress(prediction);
    setState(() {
      isLoading = false;
    });
    push(
        context,
        AddAddressManuallyScreen(
          addressData: addressRes,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FullScreenLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: appBarWidget(
          context: context,
          title: TextConstant.addAdress,
          suffixIcon: TextButton(
            onPressed: () {
              pushNamed(
                context,
                AddAddressManuallyScreen.routeName,
              );
            },
            child: const Text(TextConstant.skip),
          ),
        ),
        body: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  addAdressImage,
                )).padSymmetric(
              vertical: context.sizeHeight(0.07),
            ),
            GestureDetector(
              child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: TagoLight.textFieldBorder, width: 1)),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search,
                          color: TagoLight.textFieldBorder,
                        ),
                      ),
                      Text(
                        TextConstant.enterAnewAddress,
                        style: AppTextStyle.hintTextStyleLight,
                      ),
                    ],
                  )),
              onTap: () {
                openSearchWidget("");
              },
            ),
            Text(
              TextConstant.thishelpsTagotofind,
              style: context.theme.textTheme.bodyMedium,
            ).padSymmetric(vertical: 10),
            TextButton.icon(
              onPressed: () async {
                final currentPosition = ref.watch(getCurrentLocationProvider);
                var lat = currentPosition.asData!.value.latitude;
                var lng = currentPosition.asData!.value.longitude;
                setState(() {
                  isLoading = true;
                });
                var address = await getCurrentLocationAddress(lat, lng);
                openSearchWidget(address.streetAddress);
              },
              icon: const Icon(Icons.location_on, size: 15),
              label: const Text(TextConstant.usemycurrentlocation),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                pushNamed(
                  context,
                  AddAddressManuallyScreen.routeName,
                );
              },
              child: const Text(TextConstant.typeaddressmanually),
            ).padOnly(bottom: 16)
          ],
        ).padAll(20),
      ),
    );
  }
}

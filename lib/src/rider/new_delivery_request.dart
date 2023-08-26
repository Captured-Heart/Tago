import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tago/app.dart';
import 'package:tago/config/extensions/debug_frame.dart';
import 'package:tago/config/google%20map/get_current_location.dart';

class NewDeliveryRequestScreen extends ConsumerStatefulWidget {
  const NewDeliveryRequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewDeliveryRequestScreenState();
}

class _NewDeliveryRequestScreenState
    extends ConsumerState<NewDeliveryRequestScreen> {
  @override
  void initState() {
    ref.read(getCurrentLocationProvider);
    super.initState();
  }

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final currentPosition = ref.watch(getCurrentLocationProvider);
    return Scaffold(
      body: Column(
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Expanded(
              child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                currentPosition.value?.latitude ?? 20,
                currentPosition.value?.longitude ?? 12.2,
              ),
            ),
          ).debugBorder()),

          //
          SizedBox(
            height: context.sizeHeight(0.47),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // padding: const EdgeInsets.symmetric(horizontal: 20),

              children: [
                Expanded(
                    child: Scrollbar(
                  controller: scrollController,
                  interactive: true,
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        leading: Image.asset(
                          drinkImages[2],
                        ),
                        title: const Text(
                          'Fanta Drink - 50cl Pet x 12',
                          textAlign: TextAlign.left,
                        ),
                        shape: const Border(bottom: BorderSide(width: 0.1)),
                      ).padOnly(bottom: 8),

                      //delivering to
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            TextConstant.deliveringTo,
                            textAlign: TextAlign.left,
                            style: context.theme.textTheme.bodyLarge,
                          ),
                          ListTile(
                            // dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'Samuel Adekanbi',
                              textAlign: TextAlign.left,
                            ),
                            subtitle: const Text('090000345303'),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.phone,
                                color: TagoLight.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        minVerticalPadding: 20,
                        leading: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.pedal_bike,
                              color: TagoLight.primaryColor,
                            ),
                          ],
                        ),
                        minLeadingWidth: 10,
                        title: Text('Pickup Location'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Warehouse 1, 12B, Bolaji Akunkunmi Road, VGC Lekki, Lagos',
                            ).padSymmetric(vertical: 8),
                            Text('12km away')
                          ],
                        ),
                      ),
                      authTextFieldWithError(
                        controller: TextEditingController(),
                        context: context,
                        isError: false,
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        hintText: TextConstant.enterAnewAddress,
                      ),

                      Text(
                        TextConstant.addressLabel,
                        textAlign: TextAlign.left,
                        style: context.theme.textTheme.bodyLarge,
                      ),
                      authTextFieldWithError(
                        controller: TextEditingController(),
                        context: context,
                        isError: false,
                        hintText: TextConstant.egOffice,
                      ),
                    ].columnInPadding(10),
                  ),
                )),
                SizedBox(
                  width: context.sizeWidth(1),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(TextConstant.saveandContinue),
                  ),
                ).padSymmetric(vertical: 30)
              ],
            ).padSymmetric(horizontal: 20),
          ),
        ],
      ),
    );
  }
}
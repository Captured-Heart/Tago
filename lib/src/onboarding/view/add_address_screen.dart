import 'package:tago/app.dart';
import 'package:http/http.dart' as http;
import 'package:tago/core/network/networking.dart';

class AddAddressScreen extends ConsumerWidget {
  static const String routeName = 'add address';
  const AddAddressScreen({super.key});

  void searchAddress() async {
    // Uri.https(authority)
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Paris&types=geocode&key=$googleAPIKey',
      ),
    );
    log(response.body);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final currentPosition  = ref.watch(getCurrentLocationProvider);
    return Scaffold(
      appBar: appBarWidget(
        context: context,
        title: TextConstant.addAdress,
        suffixIcon:
            TextButton(onPressed: () {}, child: const Text(TextConstant.skip)),
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
            TextConstant.thishelpsTagotofind,
            style: context.theme.textTheme.bodyMedium,
          ).padSymmetric(vertical: 10),

          //! TYPING ADRESS WIDGET IS COMMMENTED OUT
          //  const ListTile(
          //     minLeadingWidth: 1,
          //     shape: Border(bottom: BorderSide(width: 0.2, color: Colors.grey)),
          //     leading: Icon(Icons.location_on),
          //     title: Text('12, Adesemoye Avenue'),
          //     subtitle: Text('Ikeja, Lagos, Nigeria'),
          //   ),
          TextButton.icon(
            onPressed: () {
              ref.read(getCurrentLocationProvider);
            },
            icon: const Icon(Icons.location_on, size: 15),
            label: const Text(TextConstant.usemycurrentlocation),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              // pushNamed(context, AddAddressManuallyScreen.routeName);
              // searchAddress();
            },
            child: const Text(TextConstant.typeaddressmanually),
          ).padOnly(bottom: 16)
        ],
      ).padAll(20),
    );
  }
}

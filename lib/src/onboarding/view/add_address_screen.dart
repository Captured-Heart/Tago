

import 'package:tago/app.dart';

class AddAddressScreen extends ConsumerWidget {
  static const String routeName = 'add address';
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onPressed: () {},
            icon: const Icon(Icons.location_on, size: 15),
            label: const Text(TextConstant.usemycurrentlocation),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              pushNamed(context, AddAddressManuallyScreen.routeName);
            },
            child: const Text(TextConstant.typeaddressmanually),
          ).padOnly(bottom: 16)
        ],
      ).padAll(20),
    );
  }
}
